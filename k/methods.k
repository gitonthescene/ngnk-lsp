\l import.k
(.`imp)[`sem;"semantic.k"]
(.`imp)[`json;"json.k"]
(.`imp)[`u;"utils.k"]

LANGID:"ngnklsp"
SERVERINFO:("name";"version")!(LANGID;"0.0.0")

CAP:json.prs@1:"cap.json"
semcap:{("legend";"full")!(("tokenTypes";"tokenModifiers")!$sem.lgd;`true)}
tdscap:{CAP["textDocumentSync"]}
poscap:{CAP["positionEncoding"]}


cap:{!/(("positionEncoding";"semanticTokensProvider";"textDocumentSync")
        (poscap[x]; semcap[x]; tdscap[x]))}

stub:{()}
initialize:{("capabilities";"serverInfo")!(cap[x];SERVERINFO)}
initialized:stub
shutdown:{`null}
exit:{`exit}

DOCS:()!()
didopn:{$[LANGID~(doc:x"textDocument")"languageId";DOCS[doc"uri"]:1(u.utf16off@)\doc"text";`err@"stub"];()}
didchg:{d:x"textDocument";$[*^(!DOCS)?d@:"uri";`err@"stub";]; do:DOCS@d
        DOCS[d]:do{ r:u.p2o[u.no[os:-1+\x 1;*x]].'+.y["range"]("start";"end")
                    r:$[~/r;r;0 1+0^*'1|:\&</r>\:os]
                    x?[;r;]'1(u.utf16off@)\y["text"]}/x"contentChanges";()}

semtok:{d:x"textDocument";$[ \*^(!DOCS)?d@:"uri";`err@"stub";]; doc:DOCS@d
        (,"data")!,sem.tkn[(doc 0; -1+\doc 1)]}

LKUP:!/(("textDocument/didOpen";"textDocument/didChange";"$/cancelRequest";"textDocument/semanticTokens/full")
        (didopn;didchg;stub;semtok))
