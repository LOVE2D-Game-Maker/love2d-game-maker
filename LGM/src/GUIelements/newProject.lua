--temporary Project creator dialog
--Started by BobbyJoness
--Only mentioned it was started by me so I can say I suck at Graphics Design and Programming



local Project = Class{}

function Project:init( x, y, font )
	self.x = x
	self.y = y
	self.font = font
	self.buttons = {}
	self.textBoxes = {}

end

function Project:addButton( text, x, y, id, func, argTable )
	self.buttons.id = { text = text, x = x, y = y, func = func, args = argTable }

end

function Project:drawButton( text, x, y )
	love.graphics.print( text, x, y )

end

function Project:drawButtons( )
	for k, button in pairs( self.buttons ) do
		self:drawButton( button.text, button.x, button.y )
	end

end

function Project:clickButton( cx, cy, x, y, width, height )
	if cx > x and cx < x + width and cy > y and cy < y + height then
		return true
	end

end

function Project:clickButtons( x, y )
	for k, button in pairs( self.buttons ) do
		if self:clickButton( x, y, button.x, button.y, self.font:getWidth(button.text), self.font:getHeight() ) then
			button.func( args, path )
		end
	end

end

function Project:addTextBox( x, y,  )

end



