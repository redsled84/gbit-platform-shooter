BT = require "lib.behaviour_tree"
Entity = require "entity"
World = require "world"

local gravity, terminalVelocity
gravity = 1000
terminalVelocity = 750

class Enemy extends Entity
	new: (@goals, @sprite, @health, @goalCounter=1) =>
		@currentGoal = @goals[@goalCounter]
		-- 1 FOR GOING TO RIGHT, -1 FOR GOING TO LEFT
		@direction = 1
		@vx = 100
		@vy = 0
		@jumpVelocity = -400
		@dx = 0
		@dy = 0
		@walkSpeed = 100
		super @currentGoal.x, @currentGoal.y, nil, nil, @sprite\getWidth!, @sprite\getHeight! * 2, {255, 255, 255}, @sprite
	getNextGoal: =>
		return @direction > 0 and @goals[@goalCounter+1] or @goals[@goalCounter-1]
	removed: false
	damage: (amount) =>
		@health = @health - amount < 0 and 0 or @health - amount
	movementSequence: =>
		BT\new {
			object: self
			tree: BT.Sequence\new {
				nodes: {
					BT.Task\new {
						run: (task, object) ->
							object.currentGoal = object.getNextGoal!
							task\success!
					}
					BT.Sequence\new {
						nodes: {
							BT.Task\new {
								run: (task, object) ->
									local nextGoal
									nextGoal = object.getNextGoal
									object.dx = nextGoal.x - object.x
									object.dy = object.y - nextGoal.y
									task\success!
							}
							BT.Priority\new {
								nodes: {
									BT.Sequence\new {
										nodes: {
											BT.Task\new {
												run: (task, object) ->
													if object.dy > 0
														task\success!
													else
														task\fail!
											}
											BT.Task\new {
												run: (task, object) ->
													object.vy = object.jumpVelocity
													task\success!
											}
										}
									}
									BT.Task\new {
										run: (task, object) ->
											if object.dx > 0
												object.vx = object.walkSpeed
												task\success!
											elseif object.dx < 0
												object.vx = -object.walkSpeed
												task\success!
											else
												object.vx = 0
												task\fail!
									}
								}
							}
						}
					}
				}
			}
		}

	update: (dt) =>
		@movementSequence!\run!
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