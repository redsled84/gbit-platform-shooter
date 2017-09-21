BT = require "lib.behaviour_tree"
Entity = require "entity"

local gravity, terminalVelocity
gravity = 1000
terminalVelocity = 750

class Enemy extends Entity
	new: (@goals, @sprite) =>
		local x, y
		x, y = @goals[1].x, @goals[1].y
		super x, y, nil, nil, @sprite\getWidth!, @sprite\getHeight!, nil, @sprite
		@vx = 100
		@health = 100
	movementSequence: =>
	update: (dt) =>
		@updateGravity dt, gravity, terminalVelocity
		local goalX, goalY, cols, len
		goalX, goalY, cols, len = @getCollisionInfo dt

		local col
		for i = 1, len
			col = cols[i]
			if col.normal.y == 1 or col.normal.y == -1
				@vy = 0
			if col.normal.x == 1
				@vx = 100
			elseif col.normal.x == -1
				@vx = -100

		@x, @y = goalX, goalY
	damage: (amount) =>
		if @health - amount < 0
			@health = 0
		else
			@health -= amount