."\\l ",`env[]`KINIT
imp.ort[`;"json-rpc.k"]
imp.ort[`u;"utils.k"]
msg:u.msg
imp.ort[`;"methods.k"]

serve:{h:u.rhdr[]
      ret:recv@u.rd@.h["content-length"]
      $[`exit~ret;`exit;#ret;`1:ret;]
      $[#ret:flsh[];`1:ret;]}

{~`exit~x}serve/0;
