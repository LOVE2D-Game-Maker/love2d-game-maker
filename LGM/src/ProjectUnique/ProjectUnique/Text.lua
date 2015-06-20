--This file handles text-based functions
Fonts = {}
prntypos = 0

function LoadFont(name,chars)
	if name == nil then
		return
	end
	
	assert((love.filesystem.exists("Resources/Fonts/" .. name)),"The font '" .. name .. "' does not exist.")
	
	if string.find(string.lower(name),"%.ttf") ~= nil then
		shrtnm = string.sub(string.lower(name),0,string.find(string.lower(name),"%.ttf")-1)
		
		if Fonts[shrtnm] == nil then
			Fonts[shrtnm] = love.graphics.newFont("Resources/Fonts/" .. name, Ternary((chars ~= nil and tonumber(chars) ~= nil),chars,15))
			return shrtnm
		end
	else
		if ImageFileisSupported("Resources/Fonts/" .. name) then
			shrtnm = string.sub(string.lower(name),0,string.find(string.lower(name),"%.")-1)
			
			if Fonts[shrtnm] == nil then
				assert((chars ~= nil or tonumber(chars) ~= nil),"The provided 'chars' value for the 'SetFont' function wasn't an array of characters!")
				Fonts[shrtnm] = love.graphics.newImageFont("Resources/Fonts/" .. name, chars)
				return shrtnm
			end
		end
	end
	return nil
end

function SetFont(name,size)
	if name == nil then
		return
	end
	
	shrtnm = string.sub(string.lower(name),0,string.find(string.lower(name),"%.")-1)
	
	if Fonts[shrtnm] == nil then
		shrtnm = LoadFont(name,size)
	end
	
	if shrtnm ~= nil then
		love.graphics.setFont(Fonts[shrtnm])
	end
end

function DrawText(text,x,y)
	love.graphics.print(Ternary((text ~= nil),text,"MISSINGNO"),Ternary((x ~= nil),x,0),Ternary((y ~= nil),y,prntypos))
	prntypos = prntypos+16
end