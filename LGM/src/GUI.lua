--This file holds all the GUI-related functions.

--It's kept separate from the other files to allow for easy updating of the project
--in the event that there may be multiple versions of the editor for multiple platforms
--that need different GUI's; such as an entirely touch-based Android version.

--This way the various versions of the application can have completely different GUI.lua
--files, and still have the same exact versions of all the other files. ;)

--First, let's load and define some stuff.]

local path = (...):gsub('GUI','') -- gets the path used to require this file. 

local Bubble = require(path..'.bubble')

local Group = require(path..'.group')
local bubbles = Group()

MenuItems = {"File","Edit","View","Tools","Help"}
MenuAltChars = {'F','E','V','T','H'}

arrow = love.graphics.newImage("Resources/Images/arrow.png")
arrow2 = love.graphics.newImage("Resources/Images/arrowexpand.png")

ToolbarTools = {
	{love.graphics.newImage("Resources/Images/new.png"),10,30},
	{love.graphics.newImage("Resources/Images/open.png"),40,34},
	{love.graphics.newImage("Resources/Images/save.png"),70,30},
	{"separator",104},
	{love.graphics.newImage("Resources/Images/play.png"),108,30},
	{love.graphics.newImage("Resources/Images/build.png"),138,30},
	{love.graphics.newImage("Resources/Images/settings.png"),168,30},
	{"separator",202},
	{love.graphics.newImage("Resources/Images/sprite.png"),206,30,AddResource,1},
	{love.graphics.newImage("Resources/Images/object.png"),236,30,AddResource,2},
	{love.graphics.newImage("Resources/Images/bg.png"),266,30,AddResource,3},
	{love.graphics.newImage("Resources/Images/sound.png"),296,30,AddResource,4},
	{love.graphics.newImage("Resources/Images/script.png"),326,30,AddResource,5},
	{love.graphics.newImage("Resources/Images/room.png"),356,30,AddResource,6},
	{"separator",390},
	{love.graphics.newImage("Resources/Images/help.png"),394,29}
}

--Then let's set a few things.
love.graphics.setDefaultFilter("nearest","nearest",0)
love.window.setTitle("Untitled - LOVE Game Maker")
love.graphics.setBackgroundColor(144,212,242)
love.window.setMode(800,600,{resizable = true, minwidth = 800,minheight = 600,fsaa=0})

--[[function love.keypressed(key)
	--TODO: Add stuff
end--]]

function love.mousepressed(x, y, button)
	if button == "l" then
		if rslistexpanded then
			y2 = 77
			
			for i, rstype in ipairs(Resources.Types) do
				if x >= 5 and x <= Ternary((table.getn(Resources[i]) > 0 and Resources[i].expanded ~= nil and Resources[i].expanded),17,15)+love.graphics.getFont():getWidth(rstype) and y >= y2 and y <= y2+16 then
					if table.getn(Resources[i]) < 1 then
						bubbles:add(Bubble(x,y,x+20,y+20,3.2,"There are no " .. Resources.Types[i] .. "!\n\nYou need to add some\nbefore you can expand the\nlist. ;)"))
					else
						Resources[i].expanded = not Resources[i].expanded
					end
				end
				y2 = y2 + 16
			
				if table.getn(Resources[i]) > 0 and Resources[i].expanded ~= nil and Resources[i].expanded then
					for o, rs in ipairs(Resources[i]) do
						y2 = y2 + 16
					end
				end
			end
		end
		
		if ((rslistexpanded and love.mouse.getX() >= 180 and love.mouse.getX() <= 180+20) or (not rslistexpanded and love.mouse.getX() >= 0 and love.mouse.getX() <= 20)) and (love.mouse.getY() >= 72 and love.mouse.getY() <= h) then
			rslistexpanded = not rslistexpanded
		end
		
		for i, tool in ipairs(ToolbarTools) do
			if tool[1] ~= "separator" and mx >= tool[2] and mx <= tool[2]+30 and my >= tool[3] and my <= tool[3]+30 and tool[4] ~= nil then
				if tool[5] == nil then
					tool[4]()
				else
					tool[4](tool[5])
				end
			end
		end
	end
end

function love.update(dt)
	if not rslistexpanded and rslistx > -180 then
		rslistx = rslistx - 10
	elseif rslistexpanded and rslistx < 0 then
		rslistx = rslistx + 10
	end
	bubbles:update(dt)
end

function love.draw()
	--Get the width and height of the window we're drawing to.
	w,h = love.window.getMode()
	
	--Menu Strip
	love.graphics.rectangle("fill", 0, 0, w, 72)
	love.graphics.setColor(0,0,0)
	
	x = 10
	for i, mitem in ipairs(MenuItems) do
		love.graphics.print(mitem,x,5)
		
		if love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt") then
			love.graphics.line(x,5+love.graphics.getFont():getHeight(),x+love.graphics.getFont():getWidth(MenuAltChars[i]),5+love.graphics.getFont():getHeight())
		end
		
		x = x + (love.graphics.getFont():getWidth(mitem)+10)
	end
	
	--Toolbar
	mx,my,misdown = love.mouse.getX(), love.mouse.getY(), love.mouse.isDown("l")
	
	for i, tool in ipairs(ToolbarTools) do
		if tool[1] ~= "separator" then
			if mx >= tool[2] and mx <= tool[2]+30 and my >= tool[3] and my <= tool[3]+30 then
				love.graphics.setColor(Ternary((misdown),{191,223,255},{222,239,255}))
				love.graphics.rectangle("fill",tool[2]-1,tool[3]-1,27,27)
				love.graphics.setColor(Ternary((misdown),{102,167,232},{144,212,242}))
				love.graphics.rectangle("line",tool[2]-1,tool[3]-1,27,27)
			end
			
			love.graphics.setColor(255,255,255)
			love.graphics.draw(tool[1],tool[2],tool[3],0,0.4,0.4)
		else
			love.graphics.setColor(140,140,140)
			love.graphics.line(tool[2],29,tool[2],56)
		end
	end
	
	--The Resource List itself.
	if rslistx > -180 then
		love.graphics.rectangle("fill", rslistx, 72, 200, h-72)
	end
	
	if love.mouse.getX() >= rslistx+180 and love.mouse.getX() <= (rslistx+180)+20 and love.mouse.getY() >= 72 and love.mouse.getY() <= h then
		love.graphics.setColor(229,229,229)
	end
	
	love.graphics.rectangle("fill", rslistx+180, 72, 20, h-72)
	love.graphics.setColor(0,0,0)
	love.graphics.print(Ternary((rslistexpanded),"<",">"),rslistx+185,(72+h)/2)
	
	--The Resource List's Resources.
	if rslistexpanded or rslistx > -180 then
		y = 77
		for i, rstype in ipairs(Resources.Types) do
			love.graphics.setColor(Ternary((table.getn(Resources[i]) > 0),{0,176,255},{0,176,255,150}))
			love.graphics.draw(Ternary((table.getn(Resources[i]) > 0 and Resources[i].expanded ~= nil and Resources[i].expanded),arrow2,arrow),rslistx+5,y+2)
			love.graphics.print(rstype,rslistx+Ternary((table.getn(Resources[i]) > 0 and Resources[i].expanded ~= nil and Resources[i].expanded),17,15),y)
			y = y + 16
			
			if table.getn(Resources[i]) > 0 and Resources[i].expanded ~= nil and Resources[i].expanded then
				for o, rs in ipairs(Resources[i]) do
					love.graphics.print(Ternary((rs.name == nil),o,rs.name),rslistx+22,y)
					y = y + 16
				end
			end
		end
	end
	
	--And, lastly, any other minor things that need to be drawn.
	--DrawBubbles()
	bubbles:draw()
	love.graphics.setColor(255,255,255) --Reset the color to white.
end