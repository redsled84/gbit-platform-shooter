World = require "world"

collisionFilter = (items, other) ->
  if other.__class.__name == "Player"
    return "cross"
  return "slide"

class Bullet
  new: (@x, @y, @goalX, @goalY, @speed, @width, @height, @damage) =>
  calculateDirections: =>
    local distance
    distance = math.sqrt math.pow(@goalX - @x, 2) + math.pow(@goalY - @y, 2)
    @directionX = (@goalX - @x) / distance
    @directionY = (@goalY - @y) / distance
  update: (dt) =>
    local futureX, futureY
    futureX = @x + @directionX * @speed * dt
    futureY = @y + @directionY * @speed * dt

    local goalX, goalY, cols, len
    goalX, goalY, cols, len = World\move self, futureX, futureY, collisionFilter

    @x = goalX
    @y = goalY

    return cols, len

return Bullet