--Keyboard
function keyisDown(key)
    return love.keyboard.isDown(key)
end

function love.keypressed(key)
    if Keypressed ~= nil then
        Keypressed(key)
    end
	
	if Rooms[currentroom] ~= nil  then
		if Rooms[currentroom].Keypressed ~= nil then
			Rooms[currentroom]:Keypressed(key)
		end
		
		if Rooms[currentroom].Objects ~= nil then
			for i, obj in ipairs(Rooms[currentroom].Objects) do
				if obj.Keypressed ~= nil then
					obj:Keypressed(key)
				end
			end
		end
	end
end

--Mouse
MousePos = {}

function GetMousePos()
	MousePos = {love.mouse.getX(),love.mouse.getY()}
end

function love.mousepressed(x,y,btn)
	if Mousepressed ~= nil then
		Mousepressed(x,y,btn)
	end
	
	if Rooms[currentroom] ~= nil then
		if Rooms[currentroom].Mousepressed ~= nil then
			Rooms[currentroom]:Mousepressed(x,y,btn)
		end
		
		if Rooms[currentroom].Objects ~= nil then
			for i, obj in ipairs(Rooms[currentroom].Objects) do
				if obj.Mousepressed ~= nil then
					obj:Mousepressed(x,y,btn)
				end
			end
		end
	end
end

function love.mousemoved(x,y,dx,dy)
	if Mousemoved ~= nil then
		Mousemoved(x,y,dx,dy)
	end
	
	if Rooms[currentroom] ~= nil then
		if Rooms[currentroom].Mousemoved ~= nil then
			Rooms[currentroom]:Mousemoved(x,y,dx,dy)
		end
		
		if Rooms[currentroom].Objects ~= nil then
			for i, obj in ipairs(Rooms[currentroom].Objects) do
				if obj.Mousemoved ~= nil then
					obj:Mousemoved(x,y,dx,dy)
				end
			end
		end
	end
end