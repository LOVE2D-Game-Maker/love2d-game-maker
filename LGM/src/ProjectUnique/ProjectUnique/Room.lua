Rooms = {}
Room = Class{}

--Functions related to the Room class
function Room:init()
	self.Objects = {} --The table that holds all spawned objects
	self.Backgrounds = {} --The table that holds every background on each layer
end

function Room:Print()
	if self ~= nil then
		for i, back in ipairs(self.Backgrounds) do
			DrawBackground(back,Ternary((back.x ~= nil),back.x,0),Ternary((back.y ~= nil),back.y,0),Ternary((back.dowrap ~= nil),back.dowrap,false))
		end
		
		for i, obj in ipairs(self.Objects) do
			obj:Draw()
		end
		
		if self.Draw ~= nil then
			self:Draw()
		end
	end
end

function Room:Update()
	if self ~= nil then
		for i, obj in ipairs(self.Objects) do
			if obj.Step ~= nil then
				obj:Step()
			end
		end
	end
	
	if self.Step ~= nil then
		self:Step()
	end
end

function Room:AddObject(obj,x,y)
	if self ~= nil and obj ~= nil then
		table.insert(self.Objects,obj(x,y,table.getn(self.Objects)+1))
		
		if self.Objects[table.getn(self.Objects)].Create ~= nil then
			self.Objects[table.getn(self.Objects)]:Create()
		end
	end
end

function Room:RemoveObject(id)
	--Don't continue unless self is defined to prevent errors from in-correct use of the function.
	if self ~= nil then
		if id == nil then
			id = table.getn(self.Objects) --If no id is given we simply remove most recently-added object.
		end
		
		--First, remove the actual object itself.
		if self ~= nil and id ~= 0 and table.getn(self.Objects) >= id then
			table.remove(self.Objects,id)
		end
		
		--Then, decrement the id's of all objects with higher id's than the object we just removed to fill any empty id's.
		for i, obj in ipairs(self.Objects) do
			if id < obj.id then
				obj.id = obj.id - 1
			end
		end
	end
end

--Other room-related functions
function LoadRoom(rm)
	if table.getn(Rooms) >= rm and Rooms[rm] ~= nil and Rooms[rm].Load ~= nil then
		Rooms[rm]:Load()
	end
end