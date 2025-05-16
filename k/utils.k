imp.imp[`json;"json.k"]

gl:{(~"\n"=*|:){x,1:(0;!2)}/""}
rd:{1:(0;0,x)}
rhdr0:{r:1(0,/:*'&'":"=)\-2_'1_-1_(~"\r\n"~)gl\();!/(_:;::)@'+_'/|r}
rhdr:rhdr0 / Should catch and deal with errors

whdr:{,/(": "/("Content-Length";$x);""),\:"\r\n"}
msg:{$[~#ms:(~#:')_x;();|/`exit~/:ms;`exit;whdr[#t],t:json.dmp@((::;*:)(1=#x))@(!/+:)'ms]}

enm:{*(x~/:@[;`name]')#y[`enumerations]}

nl:|/"\r\n"=\:
no:{n@??/2#,n:-1^x@-1,&nl@y}                / no[offs;txt]     -> nl offs
o2p:{*+(n;-1+-/-1^(y;x@n:x'y))}             / o2p[nl;off] -> lineno,col
p2o:{z+1+x@y}                               / p2o[nl;line;col] -> off
off:{@[&#x;(-2_((+/1(!#:)\1+4!1+0xc0e0f000'x)@)\0;&(!0),("\n\r"~,)':x);:;1 0]}
utf16off:{{-1_@[y,0;i+1+4!p;+;3=p:1+0xc0e0f000'x@i:-1+&<':y]}[x;off@x]}
