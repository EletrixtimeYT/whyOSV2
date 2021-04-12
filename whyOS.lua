local api = require("/whyOS/api")
active = 1
local background_color = colors.gray
local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end
function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end
function render_win(value)
	for x = value.x,value.x+value.width do
		for y = value.y,value.y+value.height do
			term.setCursorPos(x,y)
			if y == value.y then
				term.setBackgroundColor(colors.blue)
				term.setTextColor(colors.white)
				if x-value.x < string.len(value.title) then
					print(string.sub(value:getTitle(), x-value.x+1,x-value.x+1))
				else
					print(" ")
				end
			else
				term.setBackgroundColor(colors.white)
				if not value:getLabelOnPos(x,y) then
					if not value:getButtonOnPos(x,y) then
						print(" ")
					else
						term.setCursorPos(x,y)
						term.setBackgroundColor(colors.lightGray)
						term.setTextColor(colors.black)
						print(value:getButtonCharOnPos(x+1,y))
					end
				else
					term.setBackgroundColor(value:getLabelBColorOnPos(x+1,y))
					term.setTextColor(value:getLabelTColorOnPos(x+1,y))
					print(value:getLabelCharOnPos(x+1,y))
				end
				
			end
			if x == value.x+value.width and y == value.y and value.canclose then
				term.setCursorPos(x,y)
				term.setBackgroundColor(colors.red)
				term.setTextColor(colors.white)
				print("X")
			end
		end
	end 
end
function render()
	for key,value in pairs(api.window_list) do --actualcode
		local w,h = term.getSize()
		if api.window_list[key].x+api.window_list[key].width > w then
			api.window_list[key].x = w-api.window_list[key].width
		end
		if api.window_list[key].y+api.window_list[key].height > h-2 then
			api.window_list[key].y = h-api.window_list[key].height-1
		end
		render_win(api.window_list[key])
	end
end
explorer = api.Window:new(1,5,15,6,"Desktop")
for _,file in ipairs(fs.list("/whyOS/")) do
	if ends_with(file,".lua") and file ~= "whyOS.lua" and file ~= "api.lua" and file ~= "installer.lua" then
		local clickme = api.Button:new(2,table.getn(explorer.buttons)+1,require(file:gsub('.lua','')).name)
		clickme.run = function()
			if inTable(api.window_list,require(file:gsub('.lua','')).win) == false then
				api.window_list[table.getn(api.window_list)+1] = require(file:gsub('.lua','')).win
			end
		end
		explorer:AddButton(clickme)
	end
end
table.insert(explorer.buttons,clickme)
explorer.canclose = false
window_list[0] = explorer
render()
while true do
  term.setBackgroundColor(background_color)
  term.clear()
  render()
  event, p1,p2,p3 = os.pullEvent()
  local w, h = term.getSize()
  for key,value in pairs(window_list) do --actualcode
		if event == "mouse_drag" then
			if window_list[key].x-3 < p2 and window_list[key].x + window_list[key].width+3 > p2 and window_list[key].y-3 < p3 and window_list[key].y+3 > p3 then
				window_list[key].x = p2
				window_list[key].y = p3
				do break end
			end
		end
		if event == "mouse_click" then
			if api.window_list[key].x+api.window_list[key].width == p2 and api.window_list[key].y == p3 and api.window_list[key].canclose then
				table.remove(window_list,key)
				do break end
			end
			if api.window_list[key].x < p2 and api.window_list[key].x+api.window_list[key].width > p2 and p3 > api.window_list[key].y and p3 < api.window_list[key].y+api.window_list[key].height then
				if api.window_list[key]:getButtonOnPos(p2,p3) then
					api.window_list[key]:buttonClickedOnPos(p2,p3)
				end
				for key2,value2 in pairs(api.window_list) do
					api.window_list[key2].active = false
				end
				api.window_list[key].active = true
			end
		end
		--h = h-1
		if api.window_list[key].x+api.window_list[key].width > w then
			api.window_list[key].x = w-api.window_list[key].width
		end
		if api.window_list[key].y+api.window_list[key].height > h-2 then
			api.window_list[key].y = h-api.window_list[key].height-1
		end
  end
end