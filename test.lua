local api = require("/whyOS/api")
local win = api.Window:new(1,1,5,3,"App")
local name = "TestApp"
return {win = win, name = name}