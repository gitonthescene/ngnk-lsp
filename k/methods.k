\l import.k
imp[`sem;"semantic.k"]
imp[`json;"json.k"]
imp[`u;"utils.k"]

LANGID:"ngnklsp"
SERVERINFO:("name";"version")!(LANGID;"0.0.0")

CAP:json.prs@1:"cap.json"
semcap:{("legend";"full")!(("tokenTypes";"tokenModifiers")!$sem.lgd;`true)}
tdscap:{CAP["textDocumentSync"]}
poscap:{CAP["positionEncoding"]}
diacap:{("interFileDependencies";"workspaceDiagnostics";"identifier")!(`true;`false;LANGID)}

cap:{!/+(("positionEncoding";poscap[x])
         ("semanticTokensProvider";semcap[x])
         ("textDocumentSync";tdscap[x])
         ("diagnosticProvider";diacap[x]))}

stub:{()}
initialize:{("capabilities";"serverInfo")!(cap[x];SERVERINFO)}
initialized:stub
shutdown:{`null}
exit:{`exit}

DOCS:()!()
didopn:{$[LANGID~(doc:x"textDocument")"languageId";DOCS[doc"uri"]:1(u.utf16off@)\doc"text";`err@"stub"];()}
didchg:{d:x"textDocument";$[*^(!DOCS)?d@:"uri";`err@"stub";]; do:DOCS@d
        DOCS[d]:do{d:1(u.utf16off@)\y["text"]
                   $[^(!y)?"range";:d;]
                   r:u.p2o[u.no[os:-1+\x 1;*x]].'+.y["range"]("start";"end")
                   r:$[~/r;(#os)^os?r;0 1+0^*'1|:\&</r>\:os]
                   x?[;r;]'d}/x"contentChanges";()}

semtok:{d:x"textDocument";$[*^(!DOCS)?d@:"uri";`err@"stub";]; doc:DOCS@d
        (,"data")!,sem.tkn[(doc 0; -1+\doc 1)]}

tabs:{u.o2p[u.no[off;*x]]''(off:-1+\x[1],1)@1+0N 2#&1_~=':("\t"=x 0),0}
tabdiag:{$[~#t:tabs[x];:()
        ("range";"message";"source")!/:(+("start";"end")!+("line";"character")!/:/:t),\:("tabs forbidden";"ngnklsp")]}

DIAG:2e3
QUEUE:()
TIMER:0
flsh:{$[DIAG>-TIMER-n:.`t[];:();];TIMER::n;ret:QUEUE,pubdiag'!DOCS
      QUEUE::();,/msg','ret}

pubdiag:{not["textDocument/publishDiagnostics";("uri";"diagnostics")!(x;tabdiag[DOCS@x])]}
diag:{("kind";"items")!("full";tabdiag@DOCS@x["textDocument"]["uri"])}

LKUP:!/+(("textDocument/didOpen";didopn)
         ("textDocument/didChange";didchg)
         ("$/cancelRequest";stub)
         ("textDocument/semanticTokens/full";semtok)
         ("textDocument/diagnostic";diag)
         ("textDocument/publishDiagnostics";pubdiag))
