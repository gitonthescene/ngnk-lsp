"""Language server for ngn/k."""

import logging
from pygls.server import LanguageServer
from lsprotocol import types as lsp
import semantic

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


def main():
    """Entry point."""
    ngnk_server.start_io()


if __name__ == '__main__':
    main()
