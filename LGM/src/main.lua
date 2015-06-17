--LÖVE Game Maker

--Require ALL the things! :D
require 'libraries.hump' --Load HUMP.
require 'resources'
require 'bubble'
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