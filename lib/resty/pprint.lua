--[[
when then string exceeds 2048 bytes ,it will not be displayed properly.
--]]
local print = print 
local tconcat = table.concat
local tinsert = table.insert
local sformat = string.format
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next

local _M = { version = "0.1" }
local MAX_DEP = 30 
local function _lprint (lua_table,ret,indent)
    indent = indent or 0
    local arg_type = type(lua_table)
    local szPrefix = srep("    ", indent)
    if indent >= MAX_DEP then
        return tinsert(ret,szPrefix.."endless")
    end
    if arg_type ~= "table"  then
        return tinsert(ret,szPrefix..tostring(lua_table))
    end 
    
    if indent == 0 then
        tinsert(ret,"{")
    end 
    indent = indent + 1
    for k, v in pairs(lua_table) do
        local vtype = type(v)
        local ktype = type(k)
        if ktype == "string" then
            k = sformat("%q", k)
        else 
            k = tostring(k)
        end
        if vtype == "table" then
            szSuffix = "{"
        end
        szPrefix = srep("    ", indent)
        formatting = szPrefix.."["..k.."]".." = "..szSuffix
        if vtype == "table"   then
            tinsert(ret,formatting)
            _lprint(v,ret, indent + 1)
            tinsert(ret,szPrefix.."},")
        else
            local szValue = ""
            if vtype == "string" then
                szValue = sformat("%q", v)
            else
                szValue = tostring(v)
            end
            tinsert(ret,formatting..szValue..",")
        end
    end
    if indent == 1 then 
        tinsert(ret,"}") 
    end 
end

function _M.lprint( ... )
    local args = {...}
    local ret = {}
    for k,v in pairs(args) do
        local r = {}
        _lprint(v,r,0)
        tinsert(ret,tconcat(r,"\n"))
    end    
    print("\n",tconcat(ret,"\n"),"\n") 
end 

function _M.pprint(...)
    local args = {...}
    for k,v in pairs(args) do
        local r = {}
        _lprint(v,r,0)
        ngx.print(tconcat(r,""))
    end  
end 

return _M
