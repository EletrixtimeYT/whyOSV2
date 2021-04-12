Window = {}
Label = {}
Button = {}
window_list = {}
Pixel = {}
M = {}
function Window:new(x, y,width,height,title)
	if width == nil then
		width = 10
	end
	if height == nil then
		height = 5
	end
	if title == nil then
		title = "win"
	end
    local obj= {}
        obj.x = x
        obj.y = y
		obj.width = width
		obj.height = height
		obj.title = title
		obj.labels = {}
		obj.buttons = {}
		obj.pixxels = {}
		obj.canclose = true

    function obj:move(x,y)
        obj.x = x
		obj.y = y
    end
	function obj:getTitle()
		return obj.title
	end
	function obj:getLabel(index)
		return obj.labels[index]
	end
	function obj:setLabel(index,label)
		obj.labels[index] = label
	end
	function obj:getLabelOnPos(x,y)
		local index = false
		for k,v in pairs(obj.labels) do
			if obj.labels[k].x-1 < x-obj.x and obj.labels[k].x+string.len(obj.labels[k].text) > x-obj.x and obj.labels[k].y == y-obj.y then
				index = true
			end
		end
		return index
	end
	function obj:getLabelCharOnPos(x,y)
		local character = ""
		for k,v in pairs(obj.labels) do
			if obj.labels[k].x-1 < x-obj.x and obj.labels[k].x+string.len(obj.labels[k].text)+1 > x-obj.x and obj.labels[k].y == y-obj.y then
				character = string.sub(obj.labels[k].text,x-obj.x-obj.labels[k].x,x-obj.x-obj.labels[k].x)
			end
		end
		return character
	end
	function obj:getLabelTColorOnPos(x,y)
		local color = colors.black
		for k,v in pairs(obj.labels) do
			if obj.labels[k].x-1 < x-obj.x and obj.labels[k].x+string.len(obj.labels[k].text)+1 > x-obj.x and obj.labels[k].y == y-obj.y then
				color = obj.labels[k].textcolor
			end
		end
		return color
	end
	function obj:getLabelBColorOnPos(x,y)
		local color = colors.black
		for k,v in pairs(obj.labels) do
			if obj.labels[k].x-1 < x-obj.x and obj.labels[k].x+string.len(obj.labels[k].text)+1 > x-obj.x and obj.labels[k].y == y-obj.y then
				color = obj.labels[k].backcolor
			end
		end
		return color
	end
	function obj:changeLabel(label)
		for k,v in pairs(obj.labels) do
			if obj.labels[k].x-1 < label.x and obj.labels[k].x+string.len(obj.labels[k].text)+1 > label.x and obj.labels[k].y == label.y then
				obj.labels[k] = label
			end
		end
	end
	function obj:getButtonOnPos(x,y)
		local index = false
		for k,v in pairs(obj.buttons) do
			if obj.buttons[k].x-1 < x-obj.x and obj.buttons[k].x+string.len(obj.buttons[k].text) > x-obj.x and obj.buttons[k].y == y-obj.y then
				index = true
			end
		end
		return index
	end
	function obj:AddLabel(label)
		obj.labels[table.getn(obj.labels)+1] = label
	end
	function obj:AddButton(button)
		obj.buttons[table.getn(obj.buttons)+1] = button
	end
	function obj:RemoveButton(x,y)
		for k,v in pairs(obj.buttons) do
			if obj.buttons[k].x-1 < x and obj.buttons[k].x+string.len(obj.buttons[k].text)+1 > x and obj.buttons[k].y == y then
				table.remove(obj.buttons,k)
			end
		end
	end
	function obj:RemoveLabel(x,y)
		for k,v in pairs(obj.buttons) do
			if obj.labels[k].x-1 < x and obj.labels[k].x+string.len(obj.labels[k].text)+1 > x and obj.labels[k].y == y then
				table.remove(obj.labels,k)
			end
		end
	end
	function obj:RemovePixel(x,y)
		for k,v in pairs(obj.pixels) do
			if obj.pixels[k].x == x and obj.pixels[k].y == y then
				table.remove(obj.pixels,k)
			end
		end
	end
	function obj:getButtonCharOnPos(x,y)
		local character = ""
		for k,v in pairs(obj.buttons) do
			if obj.buttons[k].x-1 < x-obj.x and obj.buttons[k].x+string.len(obj.buttons[k].text)+1 > x-obj.x and obj.buttons[k].y == y-obj.y then
				character = string.sub(obj.buttons[k].text,x-obj.x-obj.buttons[k].x,x-obj.x-obj.buttons[k].x)
			end
		end
		return character
	end
	function obj:buttonClickedOnPos(x,y)
		for k,v in pairs(obj.buttons) do
			if obj.buttons[k].x-1 < x-obj.x and obj.buttons[k].x+string.len(obj.buttons[k].text)+1 > x-obj.x and obj.buttons[k].y == y-obj.y then
				obj.buttons[k]:run()
			end
		end
	end
	function obj:close()
		table.remove(window_list,obj)
	end
    setmetatable(obj, self)
    self.__index = self; return obj
end
function Label:new(x, y,text,tcolor,bcolor)
	if tcolor == nil then
		tcolor = colors.black
	end
    local obj= {}
        obj.x = x
        obj.y = y
		obj.text = text
		obj.textcolor = tcolor
		obj.backcolor = bcolor

    function obj:move(x,y)
        obj.x = x
		obj.y = y
    end
    setmetatable(obj, self)
    self.__index = self; return obj
end
function Button:new(x, y,text)
    local obj= {}
        obj.x = x
        obj.y = y
		obj.text = text

    function obj:move(x,y)
        obj.x = x
		obj.y = y
    end
	function obj:run()
		
	end
    setmetatable(obj, self)
    self.__index = self; return obj
end
return {Button = Button,Label = Label,Window = Window,window_list = window_list,Pixel = Pixel}