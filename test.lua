local api = require("/whyOS/api")
-- Creating window         x y w h title
local win = api.Window:new(1,1,8,5,"App")
local name = "A normal app"
local color = {colors.blue,colors.red,colors.green,colors.lightBlue,colors.white}
--Label Example            X,Y, "text" ,text color , back color  
win:AddLabel(api.Label:new(1,1,"Hello!",colors.lime,colors.green))
--Button Example                X,Y, "text"
local mybutton = api.Button:new(1,3,"Disco!")
mybutton.run = function() 
	--You can replace label if you know x and y of label
	win:changeLabel(api.Label:new(1,1,"Demo test!",color[math.random(#color)],color[math.random(#color)]))
end
win:AddButton(mybutton)
return {win = win, name = name}
