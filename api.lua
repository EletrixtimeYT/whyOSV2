Window = {}
Label = {}
Button = {}
window_list = {}
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
		obj.pixels = {}
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
	function obj:getButtonOnPos(x,y)
		local index = false
		for k,v in pairs(obj.buttons) do
			if obj.buttons[k].x-1 < x-obj.x and obj.buttons[k].x+string.len(obj.buttons[k].text) > x-obj.x and obj.buttons[k].y == y-obj.y then
				index = true
			end
		end
		return index
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
    setmetatable(obj, self)
    self.__index = self; return obj
end
function Pixel:new(x,y,color)
	local obj= {}
        obj.x = x
        obj.y = y
		obj.color = color

    function obj:move(x,y)
        obj.x = x
		obj.y = y
    end
    setmetatable(obj, self)
    self.__index = self; return obj
end
function Label:new(x, y,text)
    local obj= {}
        obj.x = x
        obj.y = y
		obj.text = text

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
return {Button = Button,Label = Label,Window = Window,window_list = window_list}