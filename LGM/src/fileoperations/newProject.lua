--Will make a new project in the given path.
--It will create a project with a defualt main.lua, conf.lua and will include ProjectUnique
--It will also have the example file and folder structure including example rooms and scripts
--ToDo make it local for now it will be global

function newProject( pathToProjectFolder, projectName )
	local confLua = [[
function love.conf(t)
    t.identity = ]]..string.gsub(projectName, ' ', '_')..[[                   -- The name of the save directory (string)
    t.version = "0.9.2"                -- The LÖVE version this game was made for (string)
    t.console = false                  -- Attach a console (boolean, Windows only)
 
    t.window.title = ]]..projectName..[[        -- The window title (string)
    t.window.icon = nil                -- Filepath to an image to use as the window's icon (string)
    t.window.width = 800               -- The window width (number)
    t.window.height = 600              -- The window height (number)
    t.window.borderless = false        -- Remove all border visuals from the window (boolean)
    t.window.resizable = false         -- Let the window be user-resizable (boolean)
    t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
    t.window.minheight = 1             -- Minimum window height if the window is resizable (number)
    t.window.fullscreen = false        -- Enable fullscreen (boolean)
    t.window.fullscreentype = "normal" -- Standard fullscreen or desktop fullscreen mode (string)
    t.window.vsync = true              -- Enable vertical sync (boolean)
    t.window.fsaa = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.display = 1               -- Index of the monitor to show the window in (number)
    t.window.highdpi = false           -- Enable high-dpi mode for the window on a Retina display (boolean)
    t.window.srgb = false              -- Enable sRGB gamma correction when drawing to the screen (boolean)
    t.window.x = nil                   -- The x-coordinate of the window's position in the specified display (number)
    t.window.y = nil                   -- The y-coordinate of the window's position in the specified display (number)
 
    t.modules.audio = true             -- Enable the audio module (boolean)
    t.modules.event = true             -- Enable the event module (boolean)
    t.modules.graphics = true          -- Enable the graphics module (boolean)
    t.modules.image = true             -- Enable the image module (boolean)
    t.modules.joystick = true          -- Enable the joystick module (boolean)
    t.modules.keyboard = true          -- Enable the keyboard module (boolean)
    t.modules.math = true              -- Enable the math module (boolean)
    t.modules.mouse = true             -- Enable the mouse module (boolean)
    t.modules.physics = true           -- Enable the physics module (boolean)
    t.modules.sound = true             -- Enable the sound module (boolean)
    t.modules.system = true            -- Enable the system module (boolean)
    t.modules.timer = true             -- Enable the timer module (boolean)
    t.modules.window = true            -- Enable the window module (boolean)
    t.modules.thread = true            -- Enable the thread module (boolean)
end


	]]
	local madeUsing = "--"..projectName.." made using LÖVE and LÖVE Game Maker \n"
	local mainLua = madeUsing..[[
require 'ProjectUnique'
function love.load()

end

function love.update( dt )
		
end

function love.draw( )

end

]]

	path.chdir( path.abspath( path.expanduser( pathToProjectFolder ) ) )
	path.mkdir( projectName )
	path.chdir( projectName )

	local Path = path.currentdir()

	file = io.open(Path..sep.."main.lua",'w')
	file:write( mainLua )
	file:close()

	file = io.open(Path..sep.."conf.lua",'w')
	file:write( confLua )
	file:close()
	
	path.mkdir("ProjectUnique")
	copydir( workingDir..sep.."ProjectUnique" , Path ..sep.."ProjectUnique"..sep)


end

function copydir ( dirPath, copyPath )
    for file in lfs.dir(dirPath) do
        if file ~= "." and file ~= ".." then
         	local f = dirPath..sep..file
         	local cf = copyPath..sep..file
            print ("\t=> "..f.." <=")
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
            	lfs.mkdir( cf )
                copydir (f, cf)

            else
            	copyfile( f, cf )
            end
        end
    end
end

function copyfile( filePath, copyPath )
	local file1 = io.open( filePath, 'r')
	local file2 = io.open( copyPath, 'w')
	file2:write( file1:read('*a') )
	file2:flush()
	file2:close()
	file1:close()
	
end