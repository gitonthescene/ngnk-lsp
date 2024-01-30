typ:("string";"comment";"variable")
mod:()

legend:`j@`"token_types"`"token_modifiers"!lgd:`$(typ;mod)

T:(" .QESNbDAHZxd"
   "QQ.EQqQQQQQQQ"
   "EQQQQqQQQQQQQ"
   "qXXXXXQXXXXXX"
   "CCCCCnCCCCCCC"
   "n.Q.cnbdIIhI."
   "cCCCCfCCCCCCC"
   "fffffgfffffff"
   "gffefffffffff"
   "effffnfffffff"
   "h.Q..n.dII.i."
   "i.Q..n.jIjjI."
   "j.Q..n.jIjjI."
   "d.Q..n.dI.d.F"
   "F.Q..n.FI.F.."
   "I.Q..n.IIIIII"
   "XXXXXXXXXXXXX"
   "b.Q.C.bdIIhI."
   "..Q..nbdIIhI.")

sm:{C:@[&256;x[0];:;1+!#x[0]]
    (C;((1_*+y)?(1_'1_y))@\:(".",x[1])?1_*y)}

ds:"0"+!10
as:"aA"+\:!26
G:("\"\\/\n ",(ds;as;"abcdef"),"0x.";"QESNbDAHZxd")
(C;TT):sm[G;T]

nl:"\n"=
prs:{((1_*+T)?"n"){TT[x;y]}\C@x}
blk:{0N 2#&~0=':(~^((1_*+T)?x)?y),0}
cmts:{(blk["cefgC";x]),\:`comment`}
qtes:{(blk["QEq";x]),\:`string`}
chrs:{(-1 0+/:(0#,0 0),blk["ij";x]),\:`string`}
vars:{(blk[,"I";x]),\:`variable`}

pos:{l,''y-1+(-1,x)@l:(-1,x)'y}           / pos[nl;pos] -> col,lineno
tkn0:{*|{(r;y[1],,/((+(d;r))@'0,~~*d:(r:pos[x;*z])-*y;--/2#z;0^lgd?'-2#z))}[x]/[(0 0;!0);y]}

tkn:{n:&nl@x;ts:,/(cmts;qtes;chrs;vars)@\:prs[x];.[tkn0;(n;@/1<:\ts);()]}
