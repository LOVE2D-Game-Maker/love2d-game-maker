--A custom file made for Project Unique to make the loading of the HUMP libraries simpler. ;)
local path = (...):gsub('%init$', '').. '.'

Camera = require (path.."camera") --Will be used... soon. ;)
Class = require (path.."class") --This one's EXTRA important! :)
require (path.."gamestate") --May not be necessary. Will look into this one deeper.
require (path.."signal")
require (path.."timer")
require (path.."vector-light")
require (path.."vector")