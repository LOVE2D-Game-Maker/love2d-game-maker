Rooms = {}
Room = Class{}
currentroom = 1 --Not local so users can check what the currentroom is in their objects.

local path = (...):gsub('%Room$', '').. '.'
local sti = require(path.."libraries.sti")

--Functions related to the Room class
function Room:init()
	self.Objects = {} --The table that holds all spawned objects
	self.Backgrounds = {} --The table that holds every background on each layer
	self.persistent = false --Wether or not the room's state is saved in memory when rooms are switched.
end

function Room:Unload()
	if not self.persistent then
		--Delete everything within the objects and backgrounds tables without changing the tables' pointers.
		for i in pairs(self.Objects) do
			self.Objects[i] = nil
		end
		
		for i in pairs(self.Backgrounds) do
			self.Backgrounds[i] = nil
		end
	end
end

function Room:Print()
	if self ~= nil then
		for i, back in ipairs(self.Backgrounds) do
			DrawBackground(back,Ternary((back.x ~= nil),back.x,0),Ternary((back.y ~= nil),back.y,0),Ternary((back.dowrap ~= nil),back.dowrap,false))
		end
		
		if self.map ~= nil then
			self.map:setDrawRange(-roomcullx, -roomcully,roomcullw, roomcullh)
			for _, layer in ipairs(self.map.layers) do
				if layer.name ~= "Collision" then
					self.map:drawLayer(layer)
				end
			end
		end
		
		for i, obj in ipairs(self.Objects) do
			obj:Draw()
		end
		
		if self.Draw ~= nil then
			self:Draw()
		end
	end
end

function Room:Update(dt)
	if self ~= nil then
		for i, obj in ipairs(self.Objects) do
			if obj.Step ~= nil then
				obj:Step()
			end
			
			if obj.Collision ~= nil and obj.mask ~= nil then
				for i2, obj2 in ipairs(self.Objects) do --I feel like there's a more efficient way to do this... ._.
					if obj2 ~= obj and obj2.mask ~= nil and DoObjectsCollide({obj,obj2}) then
						obj:Collision(obj2); if obj2.Collision ~= nil then obj2:Collison(obj) end
					end
				end
			end
		end
		
		if self.map ~= nil then
			self.map:update()
		end
	end
	
	if self.Step ~= nil then
		self:Step(dt)
	end
end

function Room:LoadTiledLevel(levelname)
	self.map = sti.new("Resources/Levels/"..levelname)
	return self.map
end

function Room:AddObject(obj,x,y,args)
	if self ~= nil and obj ~= nil and type(obj) == "table" then
		table.insert(self.Objects,obj(x,y,table.getn(self.Objects)+1,args))
		
		if self.Objects[table.getn(self.Objects)].Create ~= nil then
			self.Objects[table.getn(self.Objects)]:Create()
		end
		return self.Objects[table.getn(self.Objects)]
	end
end

function Room:RemoveObject(id)
	if self ~= nil then --Don't continue unless self is defined to prevent errors from in-correct use of the function.
		if id == nil then
			id = table.getn(self.Objects) --If no id is given we simply remove most recently-added object.
		end
		
		--First, remove the actual object itself.
		if self ~= nil and id ~= 0 and table.getn(self.Objects) >= id then
			table.remove(self.Objects,id)
		end
		
		--Then, decrement the id's of all objects with higher id's than the object we just removed to fill any empty id's.
		for i, obj in pairs(self.Objects) do
			if id < obj.id then
				obj.id = obj.id - 1
			end
		end
	end
end

--Other room-related functions
function GotoRoom(rm)
	if table.getn(Rooms) >= rm and Rooms[rm] ~= nil and Rooms[rm].Load ~= nil then
		for i, room in ipairs(Rooms) do
			room:Unload()
		end
		
		Rooms[rm]:Load()
	end
end