."\\l ",`env[]`KINIT
imp.imp[`;"json-rpc.k"]
imp.imp[`u;"utils.k"]
msg:u.msg
imp.imp[`;"methods.k"]

serve:{h:u.rhdr[]
      ret:recv@u.rd@.h["content-length"]
      $[`exit~ret;`exit;#ret;`1:ret;]
      $[#ret:flsh[];`1:ret;]}

{~`exit~x}serve/0;
