Entity = require "entity"
World = require "world"

wallImage = love.graphics.newImage "blocks.png"
wallImage\setFilter "nearest", "nearest"

class Level
	tileSize: 128
	grid: {
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}
		{1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1}
		{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
		{1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
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
					@objects[#@objects+1] = obj
	draw: =>
		for i = 1, #@objects
			local obj
			obj = @objects[i]
			-- love.graphics.setColor 0, 0, 0
			-- love.graphics.rectangle "fill", obj.x, obj.y, obj.width, obj.height
			-- love.graphics.setColor 255, 0, 0
			-- love.graphics.rectangle "line", obj.x, obj.y, obj.width, obj.height
			love.graphics.setColor 255, 255, 255
			love.graphics.draw wallImage, obj.x, obj.y, 0, (128 / 32), (128 / 32), 0, 72 - 32

return Level