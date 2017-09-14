Entity = require "entity"
World = require "world"
-- Inventory = require "inventory"
{graphics: g, keyboard: k} = love

class Player extends Entity
  -- inventory: Inventory Pistol!, Rifle!, Shotgun!
  jumpVelocity: -500
  onGround: false
  moveWithKeys: (dt) =>
    local vx, vy, frc, dec, top, low
    frc, acc, dec, top, low = 1400, 1000, 8000, 600, 50
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
    if key == "space" or key == "w" and @onGround
      @vy = @jumpVelocity
  updateCollision: (dt) =>
    local futureX, futureY
    @updateGravity dt, 1000, 420
    futureX, futureY = @getFuturePos dt
    goalX, goalY, cols, len = World\move self, futureX, futureY

    local col
    @onGround = false
    for i = 1, len
      col = cols[i]
      if col.normal.y == -1
        @onGround = true
        @vy = 0


    @x, @y = goalX, goalY


return Player