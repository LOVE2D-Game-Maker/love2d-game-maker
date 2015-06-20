Sprites = {}

function LoadSprite(path,filename)
	if filename ~= nil then
		Sprites[string.sub(filename,0,string.find(filename,"%.")-1)] = love.graphics.newImage(path .. filename)
	else
		Sprites[string.sub(path,0,string.find(path,"%.")-1)] = love.graphics.newImage(path)
	end
end

function DrawSprite(sprite,x,y,rot,sx,sy,ox,oy)
	if sprite ~= nil then
		love.graphics.draw(sprite, Ternary((x ~= nil),x,0), Ternary((y ~= nil),y,0),Ternary((rot ~= nil),rot,0),Ternary((sx ~= nil),sx,1),Ternary((sy ~= nil),sy,1),Ternary((ox ~= nil),ox,0),Ternary((oy ~= nil),oy,0))
	end
end