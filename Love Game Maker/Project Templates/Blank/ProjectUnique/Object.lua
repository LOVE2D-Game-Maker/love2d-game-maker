Object = Class{}

function Object:init(x,y,id)
	self.x = Ternary((x ~= nil),x,0)
	self.y = Ternary((y ~= nil),y,0)
	self.id = Ternary((id ~= nil),id,-1)
end

function Object:Draw()
	if self.sprite ~= nil then
		DrawSprite(self.sprite,self.x,self.y)
	end
end