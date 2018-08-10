# lua-resty-pprint
>The pprint module provides a capability to “pretty-print” arbitrary lua data structures.


[zh](README_zh.md)

``` Lua

local pprit = require("resty.pprint").pprint
local lprint = require("resty.pprint").lprint

pprint(1,nil,{x=1,["y"]=1}) -- use ngx.print ,

lprint(1,nil,{x=1,["y"]=1}) -- use print 

```
