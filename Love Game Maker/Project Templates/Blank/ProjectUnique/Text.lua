--This file handles text-based functions
Fonts = {}
prntypos = 0 --Non-local so it can be reset at the beginning of the love.draw function.

function LoadFont(name,chars,replace)
	if name ~= nil then
		if type(name) == "string" then
			if string.find(string.lower(name),"%.ttf") ~= nil then
				local shrtnm = string.sub(string.lower(name),0,string.find(string.lower(name),"%.ttf")-1)
			
				if love.filesystem.exists(name) then
					if (replace ~= nil and replace) or ((replace == nil or not replace) and Fonts[shrtnm] == nil) then
						Fonts[shrtnm] = love.graphics.newFont(name, Ternary((chars ~= nil and tonumber(chars) ~= nil),chars,15))
					end
				elseif love.filesystem.exists("Resources/Fonts/" .. name) then
					if (replace ~= nil and replace) or ((replace == nil or not replace) and Fonts[shrtnm] == nil) then
						Fonts[shrtnm] = love.graphics.newFont("Resources/Fonts/" .. name, Ternary((chars ~= nil and tonumber(chars) ~= nil),chars,15))
					end
				end
			
				return shrtnm
			else
				local fnt = LoadImage("Resources/Fonts/" .. name)
				
				if fnt ~= nil then
					local shrtnm = string.sub(string.lower(name),0,string.find(string.lower(name),"%.")-1)
				
					assert((chars ~= nil or tonumber(chars) ~= nil),"The provided 'chars' value wasn't an array of characters!")
					if (replace ~= nil and replace) or ((replace == nil or not replace) and Fonts[shrtnm] == nil) then
						Fonts[shrtnm] = love.graphics.newImageFont(fnt, chars)
					end
					return shrtnm
				end
			end
		elseif type(name) == "userdata" then
			local shrtnm = 
			
			assert((chars ~= nil or tonumber(chars) ~= nil),"The provided 'chars' value wasn't an array of characters!")
			if (replace ~= nil and replace) or ((replace == nil or not replace) and Fonts[shrtnm] == nil) then
				Fonts[shrtnm] = love.graphics.newImageFont(name, chars)
			end
			return shrtnm
		end
	end
	
	return nil
end

function SetFont(name,size)
	if name ~= nil then
		local shrtnm = nil
		
		shrtnm = LoadFont(name,size,false)
		
		if shrtnm ~= nil and Fonts[shrtnm] ~= nil then
			love.graphics.setFont(Fonts[shrtnm])
		end
	end
end

function DrawText(text,x,y)
	love.graphics.print(Ternary((text ~= nil),text,"MISSINGNO"),Ternary((x ~= nil),x,0),Ternary((y ~= nil),y,prntypos))
	prntypos = prntypos+16
end