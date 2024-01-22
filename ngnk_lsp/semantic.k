typ:,"comment"
mod:()

legend:`j@`"token_types"`"token_modifiers"!lgd:`$(typ;mod)

cmts:{(nl;txt):(x;y)
 / leading and trailing slashes for comments
 (ls;ts):s@'&'"\n\n"~/:/:txt@-1 1+/:/:s:&'"/\\"=\:txt
 bc:(^*:')_+((#ts)#*'(0,1+ls'ts)_ls;1+ts) / pair them up to delineate block comments
 fb:#/|1(~^**:)\,(*|ls^*+bc;#txt)         / final block, goes to EOF

 cs:(|/" \n"=\:txt@-1+)#(*s)^ls           / comment characters must be preceded by a space
 cs:+|(nl;cs)@'(!d;.d:*'=1+nl'cs)         / pair with nearest newline

 (cs,bc,fb),\:`comment`}                  / comment type, no modifier

pos:{l,''y-1+(-1,x)@l:(-1,x)'y}           / pos[nl;pos] -> col,lineno 

tkn0:{*|{(r;y[1],,/((d;r)@'0,~~*d:(r:pos[x;*z])-*y;--/2#z;0^lgd?'-2#z))}[x]/[(0 0;!0);y]}

tkn:{nl:&"\n"=x;ts:cmts[nl;x];tkn0[nl;@/1<:\ts]}
tkn9:{tkn1[x];3##x}

