local api = require("/whyOS/api")
local win = api.Window:new(1,1,16,7,"Editor")
local name = "Editor"
linetable = {Label:new(1,1,"",colors.lightGray,colors.black),Label:new(1,2,"",colors.lightGray,colors.black),Label:new(1,3,"",colors.lightGray,colors.black),Label:new(1,4,"",colors.lightGray,colors.black),Label:new(1,5,"",colors.lightGray,colors.black),Label:new(1,6,"",colors.lightGray,colors.black)}
for k,v in pairs(linetable) do
	win:AddLabel(v)
end
return {win = win, name = name}