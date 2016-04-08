--This file holds everything related to imagry in Project Unique.

--Generic Images
local SupportedImageFormats = {"bmp","dds","hdr","icns","ico","gif","jpg","jpe","jpeg","png","tga"}

local function ImageFileisSupported(file)
	for i, format in ipairs(SupportedImageFormats) do
		if string.find(file,"%." .. format) ~= nil then
			return true
		end
	end
	
	return false
end

function LoadImage(img,frametable)
	if img ~= nil then
		if type(img) == "string" then
			if love.filesystem.exists(img) and ImageFileisSupported(img) then --'img' is a direct path to a file
				local sprite=love.graphics.newImage(img)
				return {spr=sprite,frameindex=1,frames=frametable or {love.graphics.newQuad(0,0,sprite:getWidth(),sprite:getHeight(),sprite:getWidth(),sprite:getHeight())}}
			elseif love.filesystem.exists("Resources/Sprites/"..img) and ImageFileisSupported("Resources/Sprites/"..img) then --'img' is a full filename with it's extension inside the "Resources/Sprites" folder.
				local sprite=love.graphics.newImage("Resources/Sprites/"..img)
				return {spr=sprite,frameindex=1,frames=frametable or {love.graphics.newQuad(0,0,sprite:getWidth(),sprite:getHeight(),sprite:getWidth(),sprite:getHeight())}}
			elseif love.filesystem.exists("Resources/Backgrounds/"..img) and ImageFileisSupported("Resources/Backgrounds/"..img) then --'img' is a full filename with it's extension inside the "Resources/Backgrounds" folder.
				return love.graphics.newImage("Resources/Backgrounds/"..img)
			else
				for i, imgtype in ipairs(SupportedImageFormats) do
					if love.filesystem.exists("Resources/Sprites/"..img..'.'..imgtype) then --'img' is a short filename without it's extension inside the "Resources/Sprites" folder.
						local sprite=love.graphics.newImage("Resources/Sprites/"..img..'.'..imgtype)
						return {spr=sprite,frameindex=1,frames=frametable or {love.graphics.newQuad(0,0,sprite:getWidth(),sprite:getHeight(),sprite:getWidth(),sprite:getHeight())}}
					end
					if love.filesystem.exists("Resources/Backgrounds/"..img..'.'..imgtype) then --'img' is a short filename without it's extension inside the "Resources/Backgrounds" folder.
						return love.graphics.newImage("Resources/Backgrounds/"..img..'.'..imgtype)
					end
				end
			end
		elseif type(img) == "userdata" then --We assume that 'img' is an image.
			return img
		end
	end
	
	return nil
end

--Sprites
Sprites = {}

function MakeSpriteFrames(framewidth,frameheight,imagewidth,imageheight)
	frames = {}
	
	for i=0,imageheight-frameheight,frameheight do
		for i2=0,imagewidth-framewidth,framewidth do
			table.insert(frames,love.graphics.newQuad(i2,i,framewidth,frameheight,imagewidth,imageheight))
		end
	end
	
	return frames
end

function DrawSprite(sprite,x,y,rot,sx,sy,ox,oy)
	if sprite ~= nil then
		love.graphics.draw(sprite["spr"], sprite["frames"][sprite["frameindex"]], Ternary((x ~= nil),x,0), Ternary((y ~= nil),y,0),Ternary((rot ~= nil),rot,0),Ternary((sx ~= nil),sx,1),Ternary((sy ~= nil),sy,1),Ternary((ox ~= nil),ox,0),Ternary((oy ~= nil),oy,0))
	end
end

function Sprite(spr,frames)
	if Sprites[spr] == nil or type(Sprites[spr]) ~= "userdata" then
		Sprites[spr] = LoadImage(spr,frames)
	end
	
	return Sprites[spr]
end

--Backgrounds
Background = Class{}

function Background:init(back,x,y,dowraph,dowrapv,hs,vs)
	self.bg = LoadImage(back)

	self.x = Ternary((x ~= nil),x,0)
	self.y = Ternary((y ~= nil),y,0)
	self.dowraph = Ternary((dowraph ~= nil),dowraph,false)
	self.dowrapv = Ternary((dowrapv ~= nil),dowrapv,false)
	self.hspd = Ternary((hs ~= nil),hs,0)
	self.vspd = Ternary((vs ~= nil),vs,0)
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