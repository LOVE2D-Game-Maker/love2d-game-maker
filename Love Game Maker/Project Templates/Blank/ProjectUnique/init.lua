--"Project Unique" is the engine behind LÖVE Game Maker; a tool allowing kids to easily create games using the LÖVE framework.
--The following is it's "core" coding. ;)

--Declare/define some variables
projectuniqueversion = "DEV 1.7"
roomcullx,roomcully,roomcullw,roomcullh = 0,0,love.graphics.getWidth(),love.graphics.getHeight()

--Require ALL the things! :D
local path = (...):gsub('%init$', '').. '.'
require (path.."libraries.hump")
require (path.."Advanced")
require (path.."Imaging")
require (path.."Object")
require (path.."Room")
require (path.."Text")
require (path.."Input")

if Begin ~= nil then
	Begin()
end

--For the up-coming GUI functionality. ;)
--[[function EnableGUI() --This makes GUI-support optional for those who don't need it. ;) ...It's a large file!
	if Button == nil then --We use a random variable defined in the GUI class to check if it's been loaded. Because why not?
		require (path.."GUI")
	end
end--]]

--Require all the 'objects' under the "Resources/Objects" folder.
local files = love.filesystem.getDirectoryItems("Resources/Objects")

for i, file in ipairs(files) do
	if string.find(file,"%.lua") ~= nil then
		require ("Resources.Objects."..string.sub(file,0,string.find(file,"%.lua")-1))
	end
end

--Require all the 'rooms' under the "Resources/Rooms" folder.
files = love.filesystem.getDirectoryItems("Resources/Rooms")

for i, file in ipairs(files) do
	if string.find(file,"%.lua") ~= nil then
		table.insert(Rooms,require ("Resources.Rooms."..string.sub(file,0,string.find(file,"%.lua")-1)))
	end
end

GotoRoom(1) --Load the first room in the 'Rooms' table... if that wasn't obvious enough. :P


--------------------------------------------------------
--Now for the wrapping of the standard LÖVE functions!--
--------------------------------------------------------

function love.update(dt)
	GetMousePos()
	
	if Rooms[currentroom] ~= nil then
		Rooms[currentroom]:Update(dt)
	end
	
	if Step ~= nil then
		return Step(dt)
	end
end

function love.draw()
	if DrawBefore ~= nil then
		DrawBefore()
	end
	
	prntypos = 0
	
	if Rooms[currentroom] ~= nil and Rooms[currentroom].Print~= nil then
		Rooms[currentroom]:Print(dt)
	end
	
	if DrawAfter ~= nil then
		return DrawAfter()
	end
end