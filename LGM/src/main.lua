--LÖVE Game Maker

--Require ALL the things! :D
love.filesystem.mount(love.filesystem.getSourceBaseDirectory(), '')
love.filesystem.mount('PU.zip', 'PU')


require 'libraries.hump' --Load HUMP.
require 'resources'
require 'libraries.pl'

sep = string.match (package.config, "[^\n]+")

lfs = require('lfs')

require('fileoperations.newProject')

testProjectDir = '~'..sep..'Desktop'
testProjectName = 'test'

--require 'bubble'
require 'GUI'

--Make some functions
function Ternary (cond,val1,val2)
	if cond ~= nil and cond then
		if val1 ~= nil then
			return val1
		end
	else
		if val2 ~= nil then
			return val2
		end
	end
end

