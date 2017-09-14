-- World = require "world"
{graphics: g} = love

class Entity
  new: (@x, @y, @vx, @vy, @width=100, @height=100, @radius=16, @colors={0, 0, 0}) =>
  drawRect: =>
    g.setColor(unpack @colors)
    g.rectangle("fill", @x, @y, @width, @height)
  -- Add x and y velocities to x and y position
  updateWithVel: (dt) =>
    @x += @vx * dt
    @y += @vy * dt
  -- Use for update position with bump
  updateWithBump: (dt, foo) =>
    @x, @y = foo dt, @x, @y
  updateVelocities: (dt, foo) =>
    @vy = foo dt, @vx
  getCircleCenter: =>
    return @x, @y
  getRectCenter: =>
    return @x + @width / 2, @y + @height / 2
  getFuturePos: (dt) =>
    return @x + @vx * dt, @y + @vy * dt

return Entity