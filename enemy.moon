inspect = require "inspect"
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
	removed: false
	movementSequence: =>
		BT\new {
			object: self
			tree: BT.Sequence\new {
				nodes: {
					BT.Task\new {
						run: (task, object) ->
							@currentGoal = @getNextGoal!
							task\success!
					}
					BT.Sequence\new {
						nodes: {
							BT.Task\new {
								run: (task, object) ->
									local nextGoal
									nextGoal = @getNextGoal!
									@dx = nextGoal.x - @x
									@dy = @y - nextGoal.y
									task\success!
							}
							BT.Priority\new {
								nodes: {
									BT.Sequence\new {
										nodes: {
											BT.Task\new {
												run: (task, object) ->
													if @dy > 0
														task\success!
													else
														task\fail!
											}
											BT.Task\new {
												run: (task, object) ->
													@jump!
													task\success!
											}
										}
									}
									BT.Task\new {
										run: (task, object) ->
											if @dx > 0
												@vx = @walkSpeed
												task\success!
											elseif @dx < 0
												@vx = -@walkSpeed
												task\success!
											else
												@vx = 0
												task\fail!
									}
								}
							}
						}
					}
				}
			}
		}

	getNextGoal: =>
		if @direction > 0 and @goalCounter + 1 <= #@goals
			return @goals[@goalCounter+1]
		@goalCounter = 1
		return @goals[@goalCounter]
	damage: (amount) =>
		@health = @health - amount < 0 and 0 or @health - amount
	update: (dt) =>
		@movementSequence!\run!
		@updateGravity dt, gravity, terminalVelocity

		if not @removed
			local goalX, goalY, cols, len
			goalX, goalY, cols, len = @getCollisionInfo dt

			local col
			@onGround = false
			for i = 1, len
				col = cols[i]
				if col.normal.y == 1 or col.normal.y == -1
					@vy = 0
					@onGround = col.normal.y == -1
				if col.normal.x == 1
					@vx = 100
				elseif col.normal.x == -1
					@vx = -100
			@x, @y = goalX, goalY
	jump: =>
		if @onGround
			@vy = @jumpVelocity
	draw: =>
		if not @removed
			love.graphics.setColor unpack @colors
			love.graphics.draw @sprite, @x, @y, 0, 2, 2