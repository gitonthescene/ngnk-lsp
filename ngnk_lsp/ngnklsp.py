"""Language server for ngn/k."""

import logging
from pygls.server import LanguageServer
from lsprotocol import types as lsp
import ngnk_lsp.semantic as semantic
import re

logging.basicConfig(filename='pygls.log', filemode='w', level=logging.DEBUG)


class NgnkLanguageServer(LanguageServer):
    """Ngnk Language Server API."""

    def __init__(self, *args):
        """Construct."""
        super().__init__(*args)


ngnk_server = NgnkLanguageServer('ngnk-server', 'v0.1')
legend = semantic.init()


@ngnk_server.feature(
    lsp.TEXT_DOCUMENT_SEMANTIC_TOKENS_FULL,
    lsp.SemanticTokensLegend(**legend),
)
def semantic_tokens(ls: NgnkLanguageServer, params: lsp.SemanticTokensParams):
    """
    Semantic token parser.

    See [[https://microsoft.github.io/language-server-protocol/specification#textDocument_semanticTokens]]
    for details on how semantic tokens are encoded.
    """
    uri = params.text_document.uri
    doc = ls.workspace.get_text_document(uri)

    data = semantic.get_semantic_tokens(bytearray(doc.source, "utf-8"))
    return lsp.SemanticTokens(data=data)


@ngnk_server.feature(lsp.TEXT_DOCUMENT_DID_CHANGE)
def did_change(ls, params: lsp.DidChangeTextDocumentParams):
    """Text document did change notification."""
    _validate(ls, params)


@ngnk_server.feature(lsp.TEXT_DOCUMENT_DID_OPEN)
async def did_open(ls, params: lsp.DidOpenTextDocumentParams):
    """Text document did open notification."""
    ls.show_message("Text Document Did Open")
    _validate(ls, params)


@ngnk_server.feature(
    lsp.TEXT_DOCUMENT_DIAGNOSTIC,
    lsp.DiagnosticOptions(
        identifier="ngnkLSPServer",
        inter_file_dependencies=True,
        workspace_diagnostics=True,
    ),
)
def text_document_diagnostic(
    params: lsp.DocumentDiagnosticParams,
) -> lsp.DocumentDiagnosticReport:
    """Return diagnostic report."""
    document = ngnk_server.workspace.get_document(params.text_document.uri)
    return lsp.RelatedFullDocumentDiagnosticReport(
        items=_validate_doc(document),
        kind=lsp.DocumentDiagnosticReportKind.Full,
    )


def _validate(ls, params):
    ls.show_message_log("Validating ngn/k source...")

    text_doc = ls.workspace.get_document(params.text_document.uri)

    diagnostics = _validate_doc(text_doc)

    ls.publish_diagnostics(text_doc.uri, diagnostics)


def _validate_doc(doc):
    """Validate json file."""
    diagnostics = []

    TABS = re.compile(r'\t+')
    for line, txt in enumerate(doc.lines):
        for m in TABS.finditer(txt):
            start, end = m.span()
            d = lsp.Diagnostic(
                range=lsp.Range(
                    start=lsp.Position(line=line, character=start),
                    end=lsp.Position(line=line, character=end),
                ),
                message="tabs forbidden",
                source=type(ngnk_server).__name__,
            )

            diagnostics.append(d)

    return diagnostics


def main():
    """Entry point."""
    ngnk_server.start_io()


if __name__ == '__main__':
    main()
