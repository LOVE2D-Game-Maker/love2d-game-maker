--This file holds most of Project Unique's more 'advanced' functions.
function Ternary(statement,trueresult,falseresult) --A simple Lua function replicating the ternary operator in other languages such as C++
	if statement then
		return trueresult
	else
		return falseresult
	end
end