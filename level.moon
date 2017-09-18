Entity = require "entity"
World = require "world"

class Level
	tileSize: 128
	grid: {
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1}
		{1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	}
	objects: {}
	new: =>
		for y = 1, #@grid
			for x = 1, #@grid[y]
				local n, obj
				n = @grid[y][x]
				if n == 1
					obj = Entity x * @tileSize, y * @tileSize, 0, 0, @tileSize, @tileSize
					World\add obj, obj.x, obj.y, obj.width, obj.height
					@objects[#@objects+1] = obj
	draw: =>
		for i = 1, #@objects
			local obj
			obj = @objects[i]
			love.graphics.setColor 0, 0, 0
			love.graphics.rectangle "fill", obj.x, obj.y, obj.width, obj.height

return Level