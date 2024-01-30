typ:("string";"comment";"variable";"number")
mod:()

legend:`j@`"token_types"`"token_modifiers"!lgd:`$(typ;mod)

T:(" .QESNbDAHZxnd"
   "QQ.EQqQQQQQQQQ"
   "EQQQQqQQQQQQQQ"
   "qXXXXXQXXXXXXX"
   "CCCCCnCCCCCCCC"
   "n.Q.cnbdIIhI.."
   "cCCCCfCCCCCCCC"
   "fffffgffffffff"
   "gffeffffffffff"
   "effffnffffffff"
   "i.Q..n.jIjjI.."
   "j.Q..n.jIjjI.."
   "d.Q..n.dI.dIdF"
   "F.Q..n.FI.FIF."
   "I.Q..n.IIIIIII"
   "XXXXXXXXXXXXXX"
   "b.Q.C.bdIIhI.."
   "h.Q..n.dI.dim."
   "m.Q..nbdIIhI.."
   "..Q..nbdIIhI..")

sm:{C:@[&256;x[0];:;1+!#x[0]]
    (C;((1_*+y)?(1_'1_y))@\:(".",x[1])?1_*y)}

ds:"0"+!10
as:"aA"+\:!26
G:("\"\\/\n ",(ds;as;"abcdef"),"0xN.";"QESNbDAHZxnd")
(C;TT):sm[G;T]
s:1_*+T

nl:"\n"=
prs:{(s?"n"){TT[x;y]}\C@x}
blk:{0N 2#&~0=':(~^(s?x)?y),0}
cmts:{(blk["cefgC";x]),\:`comment`}
qtes:{(blk["QEq";x]),\:`string`}
chrs:{(-1 0+/:(0#,0 0),blk["ij";x]),\:`string`}
vars:{(blk[,"I";x]),\:`variable`}
nums:{(((s?"i")=x@1+*:')_blk["dFhm";x]),\:`number`}

pos:{l,''y-1+(-1,x)@l:(-1,x)'y}           / pos[nl;pos] -> col,lineno
tkn0:{*|{(r;y[1],,/((+(d;r))@'0,~~*d:(r:pos[x;*z])-*y;--/2#z;0^lgd?'-2#z))}[x]/[(0 0;!0);y]}

tkn:{n:&nl@x;ts:,/(cmts;qtes;chrs;vars;nums)@\:prs[x];.[tkn0;(n;@/1<:\ts);()]}
