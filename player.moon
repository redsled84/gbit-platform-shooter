Entity = require "entity"
World = require "world"
-- Inventory = require "inventory"
{graphics: g, keyboard: k} = love

collisionFilter = (items, other) ->
  if other.__class.__name == "Bullet"
    return "cross"
  return "slide"

local gravity, terminalVelocity
gravity, terminalVelocity = 2500, 800

local vx, vy, frc, dec, top, low
frc, acc, dec, top, low = 1400, 1000, 8000, 600, 50

class Player extends Entity
  -- inventory: Inventory Pistol!, Rifle!, Shotgun!
  jumpVelocity: -1200
  onGround: false
  moveWithKeys: (dt) =>
    vx, vy = self.vx, self.vy
    if k.isDown 'a' 
      if vx > 0
        vx = vx - dec * dt
      elseif vx > -top
        vx = vx - acc * dt
    elseif k.isDown 'd'
      if vx < 0
        vx = vx + dec * dt
      elseif vx < top
        vx = vx + acc * dt
    else
      if math.abs(vx) < low
        vx = 0
      elseif vx > 0
        vx = vx - frc * dt
      elseif vx < 0
        vx = vx + frc * dt
    @vx, @vy = vx, vy

  jump: (key) =>
    if (key == "space" or key == "w") and @onGround
      @vy = @jumpVelocity
  updateCollision: (dt) =>
    local futureX, futureY
    @updateGravity dt, gravity, terminalVelocity
    futureX, futureY = @getFuturePos dt
    goalX, goalY, cols, len = World\move self, futureX, futureY, collisionFilter

    local col
    @onGround = false
    for i = 1, len
      col = cols[i]
      if col.other.__class.__name ~= "Bullet"
        if col.normal.y == -1 or col.normal.y == 1
          @onGround = true
          @vy = 0
        if col.normal.x == -1 or col.normal.x == 1
          @vx = 0

    @x, @y = goalX, goalY
  draw: (mouseX, mouseY) =>
    g.setColor 255, 255, 255
    local angle, x, y
    x, y = @getCenter!
    angle = math.atan2(y - mouseY, x - mouseX) + math.pi
    if angle < 3 * math.pi / 2 and angle > math.pi / 2
      g.draw @sprite, @x, @y, 0, -2, 2, @width / 2
    else
      g.draw @sprite, @x, @y, 0, 2, 2


return Player