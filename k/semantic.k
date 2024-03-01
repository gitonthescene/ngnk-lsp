\l import.k
(.`imp)[`u;"utils.k"]

typ:("string";"comment";"variable";"number";"label")
mod:()

legend:`j@`"token_types"`"token_modifiers"!lgd:`$(typ;mod)

T:(" .QESNbsDAHZxnd"
   "QQqEQQQQQQQQQQQ"
   "EQQQQQQQQQQQQQQ"
   "q.Q..nbsdIIhII."
   "CCCCCnCCCCCCCCC"
   "n.Q.cnbsdIIhII."
   "cCCCCfCCCCCCCCC"
   "fffffgfffffffff"
   "gffefffffffffff"
   "effffnfffffffff"
   "i.Q..nbsjIjjII."
   "j.Q..nbsjIjjII."
   "d.Q..nbsdIIdIdF"
   "F.Q..nbsFIIFIF."
   "I.Q..nbsIIIIIII"
   "srprrrrrduuhuur"
   "u.Q..nbsuuuuuu."
   "pprtppppppppppp"
   "tpppppppppppppp"
   "r.Q..nbsdIIhII."
   "XXXXXXXXXXXXXXX"
   "b.Q.CnbsdIIhII."
   "h.Q..nbsdIIdim."
   "m.Q..nbsdIIhII."
   "..Q..nbsdIIhII.")

sm:{C:@[&256;x[0];:;1+!#x[0]]
    (C;((1_*+y)?(1_'1_y))@\:(".",x[1])?1_*y)}

ds:"0"+!10
as:"aA"+\:!26
G:("\"\\/\n `",(ds;as;"abcdef"),"0xN.";"QESNbsDAHZxnd")

(C;TT):sm[G;T]
s:1_*+T

prs:{(s?"n"){TT[x;y]}\0^C@x}
blk:{0N 2#&~0=':(~^(s?x)?y),0}
cmts:{(blk["cefgC";x]),\:`comment`}
qtes:{(blk["QEq";x]),\:`string`}
chrs:{(-1 0+/:(0#,0 0),blk["ij";x]),\:`string`}
vars:{(blk[,"I";x]),\:`variable`}
nums:{(((s?"i")=x@1+*:')_blk["dFhm";x]),\:`number`}
syms:{(blk["prstu";x]),\:`label`}

tkn0:{*|{(r;y[1],,/((+(d;r))@'0,~~*d:-y[0]-r:x[*z];--/2#z;0^lgd?'-2#z))}[x]/[(0 0;!0);y]}

tkn1:{n:u.no[x;y];ts:,/(cmts;qtes;chrs;vars;nums;syms)@\:prs[y];tkn0[u.o2p[x;n];@/1<:\ts]}
tkn:{.[tkn1;|x;()]}
