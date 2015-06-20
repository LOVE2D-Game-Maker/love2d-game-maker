Background = Class{}
Backgrounds = {}

function Background:init(back,x,y,dowraph,dowrapv,hs,vs)
	self.bg = back
	self.x = Ternary((x ~= nil),x,0)
	self.y = Ternary((y ~= nil),y,0)
	self.dowraph = Ternary((dowraph ~= nil),dowraph,false)
	self.dowrapv = Ternary((dowrapv ~= nil),dowrapv,false)
	self.hspd = Ternary((hs ~= nil),hs,0)
	self.vspd = Ternary((vs ~= nil),vs,0)
end

function LoadBackground(path,filename)
	if filename ~= nil then
		Backgrounds[string.sub(filename,0,string.find(filename,"%.")-1)] = Background(love.graphics.newImage(path .. filename))
	else
		Backgrounds[string.sub(path,0,string.find(path,"%.")-1)] = Background(love.graphics.newImage(path))
	end
end

function DrawBackground(bg)
	if bg ~= nil and bg.bg ~= nil then
		love.graphics.draw(bg.bg, Ternary((bg.x ~= nil),bg.x,0), Ternary((bg.y ~= nil),bg.y,0),Ternary((bg.rot ~= nil),bg.rot,0),Ternary((bg.sx ~= nil),bg.sx,1),Ternary((bg.sy ~= nil),bg.sy,1),Ternary((bg.ox ~= nil),bg.ox,0),Ternary((bg.oy ~= nil),bg.oy,0))
		
		if bg.dowraph ~= nil and bg.dowraph and bg.dowrapv ~= nil and bg.dowrapv then
			if bg.x ~= nil and bg.y ~= nil then
				--This wraps the background around the screen both horizontally and vertically.
				for i=0-bg.bg:getWidth(), love.graphics.getWidth()+bg.bg:getWidth(), bg.bg:getWidth() do
					for o=0-bg.bg:getHeight(), love.graphics.getHeight()+bg.bg:getHeight(), bg.bg:getHeight() do
						love.graphics.draw(bg.bg, bg.x+i, bg.y+o,Ternary((bg.rot ~= nil),bg.rot,0),Ternary((bg.sx ~= nil),bg.sx,1),Ternary((bg.sy ~= nil),bg.sy,1),Ternary((bg.ox ~= nil),bg.ox,0),Ternary((bg.oy ~= nil),bg.oy,0))
					end
				end
				
				if math.abs(bg.x) >= math.abs(bg.bg:getWidth()) then
					bg.x = 0
				end
				
				if math.abs(bg.y) >= math.abs(bg.bg:getHeight()) then
					bg.y = 0
				end
			end
		elseif bg.dowraph ~= nil and bg.dowraph then
			if bg.x ~= nil and bg.y ~= nil then
				--This wraps the background around the screen just horizontally.
				for i=0-bg.bg:getWidth(), love.graphics.getWidth()+bg.bg:getWidth(), bg.bg:getWidth() do
					love.graphics.draw(bg.bg, bg.x+i, bg.y,Ternary((bg.rot ~= nil),bg.rot,0),Ternary((bg.sx ~= nil),bg.sx,1),Ternary((bg.sy ~= nil),bg.sy,1),Ternary((bg.ox ~= nil),bg.ox,0),Ternary((bg.oy ~= nil),bg.oy,0))
				end
				
				if math.abs(bg.x) >= math.abs(bg.bg:getWidth()) then
					bg.x = 0
				end
			end
		elseif bg.dowrapv ~= nil and bg.dowrapv then
			if bg.x ~= nil and bg.y ~= nil then
				--This wraps the background around the screen just vertically.
				for o=0-bg.bg:getHeight(), love.graphics.getHeight()+bg.bg:getHeight(), bg.bg:getHeight() do
					love.graphics.draw(bg.bg, bg.x, bg.y+o,Ternary((bg.rot ~= nil),bg.rot,0),Ternary((bg.sx ~= nil),bg.sx,1),Ternary((bg.sy ~= nil),bg.sy,1),Ternary((bg.ox ~= nil),bg.ox,0),Ternary((bg.oy ~= nil),bg.oy,0))
				end
				
				if math.abs(bg.y) >= math.abs(bg.bg:getHeight()) then
					bg.y = 0
				end
			end
		end
		
		--Move the background by the appropriate values if hspd or vspd is greater than 0.
		if bg.hspd ~= nil and bg.hspd ~= 0 then
			bg.x = bg.x + bg.hspd
		end
		if bg.vspd ~= nil and bg.vspd ~= 0 then
			bg.y = bg.y + bg.vspd
		end
	end
end