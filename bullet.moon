World = require "world"

collisionFilter = (items, other) ->
  if other.__class.__name == "Player"
    return "cross"
  return "slide"

class Bullet
  new: (@x, @y, @goalX, @goalY, @speed, @width, @height, @damage, @bulletDrop=.1) =>
    @vy = 0
  calculateDirections: =>
    @dx = @goalX - @x
    @dy = @goalY - @y
    @distance = math.sqrt math.pow(@goalX - @x, 2) + math.pow(@goalY - @y, 2)
    @directionX = (@dx) / @distance
    @directionY = (@dy) / @distance
  update: (dt) =>
    @vy += @bulletDrop * dt

    local futureX, futureY
    futureX = @x + @directionX * @speed * dt
    futureY = @y + @vy + @directionY * @speed * dt

    local goalX, goalY, cols, len
    goalX, goalY, cols, len = World\move self, futureX, futureY, collisionFilter

    @x = goalX
    @y = goalY

    return cols, len

return Bullet