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