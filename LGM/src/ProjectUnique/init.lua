--"Project Unique" is the engine behind Love Game Maker; a tool allowing kids to easily create
--games using the LOVE2D framework.
--As of now it's under heavy development, so don't expect anything to work 100%! ;)

--Declare/define some variables
currentroom = 1
projectuniqueversion = "DEV 1.1"
SupportedImageFormats = {"bmp","dds","hdr","icns","ico","gif","jpg","jpe","jpeg","png","tga"}

--Oh, and a few random functions. (Because I'm SO organized! :P)
function ImageFileisSupported(file)
	for i, format in ipairs(SupportedImageFormats) do
		if string.find(file,"%." .. format) ~= nil then
			return true
		end
	end
	return false
end

--Require ALL the things! :D
local path = (...):gsub('%.init$', '').. '.'
require (path.."ProjectUnique.libraries.hump")
require (path.."ProjectUnique.Advanced")
require (path.."ProjectUnique.Sprite")
require (path.."ProjectUnique.Background")
require (path.."ProjectUnique.Object")
require (path.."ProjectUnique.Room")
require (path.."ProjectUnique.Text")
require (path.."ProjectUnique.Input")

--Load all the 'sprites' under the Resources/Sprites folder.
local files = love.filesystem.getDirectoryItems("Resources/Sprites")

for i, file in ipairs(files) do
	if ImageFileisSupported(file) then
		LoadSprite("Resources/Sprites/",file)
	end
end

--Load all the 'backgrounds' under the Resources/Backgrounds folder.
files = love.filesystem.getDirectoryItems("Resources/Backgrounds")

for i, file in ipairs(files) do
	if ImageFileisSupported(file) then
		LoadBackground("Resources/Backgrounds/",file)
	end
end

--Require all the 'objects' under the Resources/Objects folder.
files = love.filesystem.getDirectoryItems("Resources/Objects")

for i, file in ipairs(files) do
	if string.find(file,"%.lua") ~= nil then
		require ("Resources.Objects."..string.sub(file,0,string.find(file,"%.lua")-1))
	end
end

--Require all the 'rooms' under the Resources/Rooms folder.
files = love.filesystem.getDirectoryItems("Resources/Rooms")

for i, file in ipairs(files) do
	if string.find(file,"%.lua") ~= nil then
		table.insert(Rooms,require ("Resources.Rooms."..string.sub(file,0,string.find(file,"%.lua")-1)))
	end
end

--Lastly, require all the 'fonts' under the Resources/Fonts folder.
files = love.filesystem.getDirectoryItems("Resources/Fonts")

for i, file in ipairs(files) do
	if string.find(string.lower(file),"%.ttf") ~= nil then
		LoadFont(file,15)
	end
end

LoadRoom(1) --Load the first room in the 'Rooms' table... if that wasn't obvious enough. :P


--------------------------------------------------------
--Now for the wrapping of the standard LOVE functions!--
--------------------------------------------------------

function love.update(dt)
	if Rooms[currentroom] ~= nil then
		Rooms[currentroom]:Update(dt)
	end
	
	if Step ~= nil then
		return Step(dt)
	end
end

function love.draw()
	prntypos = 0
	
	if Rooms[currentroom] ~= nil and Rooms[currentroom].Print~= nil then
		Rooms[currentroom]:Print(dt)
	end
	
	if Draw ~= nil then
		return Draw()
	end
end