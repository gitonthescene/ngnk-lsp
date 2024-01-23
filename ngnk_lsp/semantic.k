typ:("string";"comment")
mod:()

legend:`j@`"token_types"`"token_modifiers"!lgd:`$(typ;mod)

T:(" .SsNQE"
   "... NQ."
   " .C NQX"
   "N.c NQX"
   "QQQQq.E"
   "XXXXXXX"
   "CCCCNCC"
   "cCCCeCC"
   "egggggf"
   "ggggegg"
   "fgggNgg"
   "qXXQXXX"
   "EQQQQQQ")

C:@[1+&256;"/ \n\"\\";:;2_!#c:*T]
TT:(s:1_*+T)?(1_'1_T)

nl:"\n"=
prs:{(s?"N"){TT[x;y-1]}\C@x}
blk:{0N 2#&~0=':(~^(s?x)?y),0}
cmts:{(blk["cefgC";x]),\:`comment`}
qtes:{(0 1+/:blk["QEq";x]),\:`string`}

pos:{l,''y-1+(-1,x)@l:(-1,x)'y}           / pos[nl;pos] -> col,lineno
tkn0:{*|{(r;y[1],,/((+(d;r))@'0,~~*d:(r:pos[x;*z])-*y;--/2#z;0^lgd?'-2#z))}[x]/[(0 0;!0);y]}

tkn:{n:&nl@x;ts:,/(cmts;qtes)@\:prs[x];tkn0[n;@/1<:\ts]}
