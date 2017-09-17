Bullet = require "bullet"
World = require "world"

shootSound = love.audio.newSource "shoot.wav", "static"
shootSound\setVolume .5

class Weapon
  new: (@x, @y, @magazineSize, @sprite, @audioSource, @sprayAngle=math.pi/100) =>
    @ammoCount = @magazineSize
    @drawOffset = {x: @sprite\getWidth! / 4, y: @sprite\getHeight! / 2}
    @fireControl = "auto"
    @bulletSpeed = 2500
    @bulletSize = 6
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
    -- But we aren't calculating at the origin of the window, we need to translate the points
    -- to be relative to the weapon
    -- Thus:
    --   x = r * cos(theta) + weapon.x
    --   y = r * sin(theta) + weapon.y
    return -bullet.distance * math.cos(randomAngle) + @x, -bullet.distance * math.sin(randomAngle) + @y

  shootBullet: (x, y) =>
    local bullet
    @canShoot = false
    @ammoCount -= 1

    bullet = Bullet @x-@bulletSize, @y-@bulletSize, x-@bulletSize, y-@bulletSize,
      @bulletSpeed, @bulletSize, @bulletSize
    bullet\calculateDirections!
    bullet.goalX, bullet.goalY = @getVariableBulletVectors bullet
    -- print @x, @y, -bullet.distance * math.cos(angle) + @x, 
    bullet\calculateDirections!

    -- Add bullet to world
    @bullets[#@bullets+1] = bullet
    World\add bullet, bullet.x, bullet.y, bullet.width, bullet.height

    if shootSound\isPlaying!
      shootSound\stop!
      shootSound\play!
    else
      shootSound\play!

  shootAuto: =>
    local x, y
    x = love.mouse.getX! + 8
    y = love.mouse.getY! + 8
    if love.mouse.isDown(1) and @canShoot and @ammoCount > 0 and @fireControl == "auto"
      @shootBullet x, y

  shootSemi: (x, y, button) =>
    if button == 1 and @canShoot and @ammoCount > 0 and @fireControl == "semi"
      @shootBullet x, y

  draw: =>
    love.graphics.setColor 255, 255, 255
    local angle, scale
    scale = .25
    angle = math.atan2(@y-love.mouse.getY()-8, @x-love.mouse.getX()-8) + math.pi
  
    -- if angle < 3 * math.pi / 2 and angle > math.pi / 2
    --   love.graphics.draw @sprite, @x, @y, angle, scale, -scale, @drawOffset.x, @drawOffset.y
    -- else
    --   love.graphics.draw @sprite, @x, @y, angle, scale, scale, @drawOffset.x, @drawOffset.y
    if angle < 3 * math.pi / 2 and angle > math.pi / 2
      love.graphics.draw @sprite, @x, @y, angle, 1, -1, @drawOffset.x, @drawOffset.y
    else
      love.graphics.draw @sprite, @x, @y, angle, 1, 1, @drawOffset.x, @drawOffset.y
    love.graphics.setColor 0, 0, 0
    love.graphics.print tostring @ammoCount

return Weapon