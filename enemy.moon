BT = require "lib.behaviour_tree"
Entity = require "entity"
World = require "world"

local gravity, terminalVelocity
gravity = 1000
terminalVelocity = 750

class Enemy extends Entity
	new: (@goals, @sprite, @health) =>
		@currentGoal = @goals[1]
		@goalCounter = 1
		-- 1 FOR GOING TO RIGHT, -1 FOR GOING TO LEFT
		@direction = 1
		@vx = 100
		super @currentGoal.x, @currentGoal.y, nil, nil, @sprite\getWidth!, @sprite\getHeight! * 2, {255, 255, 255}, @sprite
	getNextGoal: =>
	removed: false
	damage: (amount) =>
		@health = @health - amount < 0 and 0 or @health - amount
	movementSequence: BT\new {
		object: self,
		tree: BT.Sequence\new {
			nodes: {

			}
		}
	}
	update: (dt) =>
		@updateGravity dt, gravity, terminalVelocity

		if not @removed
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
	draw: =>
		if not @removed
			love.graphics.setColor unpack @colors
			love.graphics.draw @sprite, @x, @y, 0, 2, 2