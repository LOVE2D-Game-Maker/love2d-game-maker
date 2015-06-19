--will basically be a table of objects will act as a basic entity manager
--expects each object to implement a standard set of methods. Some being optional.
--ToDo document the stadard methods
local Group = Class{}

function Group:init( )
	self.group = {}
	self.objID    = 0
	self.objCount = 0

end

function Group:add( obj )
	self.objID = self.objID + 1
	self.group[self.objID] = obj
	obj:setID( self.objID )
	self.objCount = self.objCount + 1

end

function Group:remove( id )
	self.group[id] = nil
	self.objCount = self.objCount - 1

end

function Group:destroy( id )
	self.group[id]:destroy( )
	self.group[id] = nil
	self.objCount = self.objCount - 1

end

function Group:destroyAll( )
	for k, obj in pairs(self.group) do 
		self:destroy(obj:getID())
	end

end

function Group:update( dt )	
	for k, obj in pairs( self.group ) do
		obj:update( dt )
		if obj.getDead and obj:getDead() then
			self:destroy(obj:getID())
		end
	end

end

function Group:draw()
	for k, obj in pairs( self.group ) do
		obj:draw( dt )
	end

end

function Group:mouseclicked( ... )
	for k, obj in pairs( self.group ) do
		obj:mouseclicked( ... )
	end

end

function Group:mousereleased(...)
	for k, obj in pairs( self.group ) do
		obj:mousereleased( ... )
	end

end

function Group:keypressed( ... )
	for k, obj in pairs( self.group ) do
		obj:keypressed( ... )
	end

end

function Group:keyreleased( ... )
	for k, obj in pairs( self.group ) do
		obj:keyreleased( ... )
	end

end

function Group:execute( method,...)
	for k, obj in pairs( self.group ) do
		obj[method]( obj, ... )
	end

end

function Group:getCount( )
	return self.objCount

end

function Group:getObject( id )
	return self.group[id]

end

return Group