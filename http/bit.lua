--[[ This module smooths over all the various lua bit libraries

The bit operations are only done on bytes (8 bits),
so the differences between bit libraries can be ignored.
]]

-- Lua 5.3 has built-in bit operators, wrap them in a function.
if _VERSION == "Lua 5.3" then
	return assert(load([[return {
		band = function(a, b) return a & b end;
		bor = function(a, b) return a | b end;
	}]]))()
end

-- The "bit" library that comes with luajit
-- also available for lua 5.1 as "luabitop": http://bitop.luajit.org/
local has_bit, bit = pcall(require, "bit")
if has_bit then
	return {
		band = bit.band;
		bor = bit.bor;
	}
end

-- The "bit32" library shipped with lua 5.2
local has_bit32, bit32 = pcall(require, "bit32")
if has_bit32 then
	return {
		band = bit32.band;
		bor = bit32.bor;
	}
end

error("Please install a bit library")
