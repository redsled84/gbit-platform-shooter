World = require "world"
{graphics: g} = love

class Entity
  new: (@x, @y, @vx=0, @vy=0, @width=100, @height=100, @colors={0, 0, 0}, @sprite) =>
    World\add self, @x, @y, @width, @height
  draw: =>
    g.setColor unpack @colors
    g.rectangle "fill", @x, @y, @width, @height
  -- Add x and y velocities to x and y position
  updateGravity: (dt, gravity, tv) => 
    @vy = @vy < tv and @vy + gravity * dt or tv
  updatePosition: (dt, gravity, tv) =>
    @updateGravity dt, gravity, tv
    @x += @vx * dt
    @y += @vy * dt
  setVelocities: (vx, vy) =>
    @vx, @vy = vx, vy
  getCenter: =>
    return @x + @width / 2, @y + @height / 2
  getFuturePos: (dt) =>
    return @x + @vx * dt, @y + @vy * dt
  getCollisionInfo: (dt, collisionFilter) =>
    local futureX, futureY
    futureX, futureY = @getFuturePos dt
    goalX, goalY, cols, len = World\move self, futureX, futureY, collisionFilter
    return goalX, goalY, cols, len

return Entity