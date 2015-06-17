--TODO: Finish the following to make nice-looking "bubbles"
--that are drawn correctly and efficiently.

--As of now, this file is kind of a mess. ._.

Bubble = Class{}
Bubbles = {}

function Bubble:init(mx,my,x,y,tm,text)
	wx,wy = love.window.getMode()
	
	self.x = mx+20
	
	--if my+100 <= wy/2 then
		self.y = my+20
	--else
		--self.y = my-20
	--end
	--self.y = my+20
	self.x2 = x
	self.y2 = y
	self.t = tm
	self.text = text
	
	self.fadingin = true
	self.fadingout = false
	self.A = 0
	
	table.insert(Bubbles,self)
end

function Bubble:Draw()
	local mx,my = love.mouse.getX(), love.mouse.getY()
	love.graphics.setColor(50,81,255,self.A)
	love.graphics.polygon("fill",mx,my,self.x,self.y,self.x-20,self.y2)
	love.graphics.rectangle("fill",self.x2-20,self.y2,200,100)
	
	if mx > self.x+5 and self.x < (self.x2-20)+200 then
		self.x = self.x + 5
	elseif mx < self.x and self.x > self.x2 then
		self.x = self.x - 5
	end
	
	love.graphics.setColor(255,255,255,self.A)
	love.graphics.print(self.text,self.x2,self.y2+20)
	
	if self.fadingin and self.A < 255 then
		self.A = self.A + 15
	elseif self.fadingin and self.A >= 255 then
		self.fadingin = false
		self.A = 255
	elseif self.fadingout and self.A > 0 then
		self.A = self.A - 15
	end
end

function DrawBubbles()
	for b, bubble in ipairs(Bubbles) do
		bubble:Draw()
		bubble.t = bubble.t - 1
		
		if bubble.t <= 0 and not bubble.fadingout then
			bubble.fadingout = true
		elseif bubble.fadingout and bubble.A <= 0 then
			table.remove(Bubbles,b)
		end
	end
end