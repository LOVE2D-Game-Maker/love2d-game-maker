Resources = { {},{},{},{},{},{} } --Initializes a table containing 6 smaller tables; one for each type of resource.
rslistexpanded = true
rslistx = 0

--Define the various types of resources that can be added to the Resources table.
Resources.Types = 
{
	"Sprites", "Objects",
	"Backgrounds","Sounds",
	"Scripts", "Rooms"
}

--Sprites
Sprite = Class{}

function Sprite:init()
	self.name = "sprite"..table.getn(Resources[1])+1
end

--Objects
Object = Class{}

function Object:init()
	self.name = "object"..table.getn(Resources[2])+1
end

--Backgrounds
Background = Class{}

function Background:init()
	self.name = "background"..table.getn(Resources[3])+1
end

--Sounds
Sound = Class{}

function Sound:init()
	self.name = "sound"..table.getn(Resources[4])+1
end

--Scripts
Script = Class{}

function Script:init()
	self.name = "script"..table.getn(Resources[5])+1
end

--Rooms
Room = Class{}

function Room:init()
	self.name = "room"..table.getn(Resources[6])+1
end

function AddResource(type)
	if type ~= nil then
		table.insert(Resources[type],Ternary((type==1),Sprite(),Ternary((type==2),Object(),Ternary((type==3),Background(),Ternary((type==4),Sound(),Ternary((type==5),Script(),Room()))))))
		Resources[type].expanded = true
	end
end