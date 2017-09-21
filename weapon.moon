Bullet = require "bullet"
World = require "world"

{graphics: g} = love

shootSound = love.audio.newSource "shoot.wav", "static"
shootSound\setVolume .2

class Weapon
  new: (@x, @y, @magazineSize, @sprite, @audioSource, @sprayAngle=math.pi/250) =>
    @ammoCount = @magazineSize
    @drawOffset = {
      x: @sprite\getWidth! / 4,
      y: @sprite\getHeight! / 2
    }
    @fireControl = "auto"
    @bulletSpeed = 2700
    @bulletSize = 6
    @damage = 20

  bullets: {}
  canShoot: true
  rateOfFire: {time: 0, max: .12}

  updateRateOfFire: (dt) =>
    if @rateOfFire.time < @rateOfFire.max and not @canShoot
      @rateOfFire.time += dt
    else
      @rateOfFire.time = 0
      @canShoot = true


  update: (dt) =>
    for i = #@bullets, 1, -1
      local b
      b = @bullets[i]
      cols, len = b\update dt
      local col
      for j = len, 1, -1
        col = cols[j]
        if col.other.__class.__name ~= "Player"
          if col.other.__class.__name == "Enemy"
            col.other.__class\damage @damage
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

  shootAuto: (x, y) =>
    local targetX, targetY
    targetX = x + 8
    targetY = y + 8
    if love.mouse.isDown(1) and @canShoot and @ammoCount > 0 and @fireControl == "auto"
      @shootBullet targetX, targetY

  shootSemi: (x, y, button) =>
    if button == 1 and @canShoot and @ammoCount > 0 and @fireControl == "semi"
      @shootBullet x, y

  draw: (x, y) =>
    g.setColor 255, 255, 255
    local angle, scale
    scale = .65
    angle = math.atan2(@y - y, @x - x) + math.pi
  
    g.setColor 0, 0, 0
    if angle < 3 * math.pi / 2 and angle > math.pi / 2
      g.draw @sprite, @x, @y, angle, scale, -scale, @drawOffset.x, @drawOffset.y
    else
      g.draw @sprite, @x, @y, angle, scale, scale, @drawOffset.x, @drawOffset.y
    -- if angle < 3 * math.pi / 2 and angle > math.pi / 2
    --   g.draw @sprite, @x, @y, angle, 1, -1, @drawOffset.x, @drawOffset.y
    -- else
    --   g.draw @sprite, @x, @y, angle, 1, 1, @drawOffset.x, @drawOffset.y
    g.print tostring @ammoCount

return Weapon