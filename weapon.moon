Bullet = require "bullet"
World = require "world"

class Weapon
  new: (@x, @y, @magazineSize, @sprayAngle=math.pi/90) =>
    @ammoCount = @magazineSize
  canShoot: true
  rateOfFire: {time: 0, max: .1}
  updateRateOfFire: (dt) =>
    if @rateOfFire.time < @rateOfFire.max and not @canShoot
      @rateOfFire.time += dt
    else
      @rateOfFire.time = 0
      @canShoot = true
  bullets: {}
  update: (dt) =>
    for i = #@bullets, 1, -1
      local b
      b = @bullets[i]
      cols, len = b\update dt
      local col
      for j = len, 1, -1
        col = cols[j]
        if col.other.__class.__name ~= "Player"
          World\remove b
          table.remove @bullets, i
          break

  getVariableBulletVectors: (bullet) =>
    local angle, goalX, goalY
    -- calculate angle, note that the origin is position of weapon
    angle = math.atan2(bullet.dy, bullet.dx) + math.pi
    randomAngle = math.random(1000 * (angle - @sprayAngle), 1000 * (angle + @sprayAngle)) / 1000

    -- negative bullet.distance because of how the trig functions return value with wrong sign
    -- Polar coordinates are found like this:
    --   x = r * cos(theta)
    --   y = r * sin(theta)
    -- But we aren't calculating at the origin of the window, we need to translate the points to be relative to the weapon
    -- Thus:
    --   x = r * cos(theta) + weapon.x
    --   y = r * sin(theta) + weapon.y
    return -bullet.distance * math.cos(randomAngle) + @x, -bullet.distance * math.sin(randomAngle) + @y

  shoot: (x, y, button, world) =>
    if button == 1 and @canShoot and @ammoCount > 0
      local bullet, bulletSize
      @canShoot = false
      @ammoCount -= 1

      bulletSize = 8
      bullet = Bullet @x, @y, x-bulletSize, y-bulletSize, 1000, bulletSize, bulletSize
      bullet\calculateDirections!
      bullet.goalX, bullet.goalY = @getVariableBulletVectors bullet
      -- print @x, @y, -bullet.distance * math.cos(angle) + @x, 
      bullet\calculateDirections!

      -- Add bullet to world
      @bullets[#@bullets+1] = bullet
      World\add bullet, bullet.x, bullet.y, bullet.width, bullet.height

return Weapon