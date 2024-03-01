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

nl:|/"\r\n"=\:
no:{n@??/2#,x@n:-1,&nl@y}                   / no[offs;txt]     -> nl offs
o2p:{*+(n;-1+-/-1^x@(z;y@n:y'z))}           / o2p[offs;nl;off] -> lineno,col
p2o:{z+1+x@y}                               / p2o[nl;line;col] -> off
off:{@[&#x;(-2_((+/1(!#:)\1+4!1+0xc0e0f000'x)@)\0;&(!0),("\n\r"~,)':x);:;1 0]}
utf16off:{{-1_@[y,0;i+1+4!p;+;3=p:1+0xc0e0f000'x@i:-1+&<':y]}[x;off@x]}

tkn1:{n:no[x;y];ts:,/(cmts;qtes;chrs;vars;nums;syms)@\:prs[y];tkn0[o2p[x;n];@/1<:\ts]}
tkn2:{tkn1[-1+\utf16off[x];x]}
tkn:{.[tkn2;,x;()]}
