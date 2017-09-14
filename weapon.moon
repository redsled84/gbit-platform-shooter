Bullet = require "bullet"
World = require "world"

class Weapon
  new: (@x, @y, @magazineSize, @accuracy=1) =>
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
  shoot: (x, y, button, world) =>
    if button == 1 and @canShoot and @ammoCount > 0
      local bullet
      @canShoot = false
      @ammoCount -= 1
      bullet = Bullet @x, @y, x, y, 1000, 12, 12
      bullet\calculateDirections!
      @bullets[#@bullets+1] = bullet
      World\add bullet, bullet.x, bullet.y, bullet.width, bullet.height

return Weapon