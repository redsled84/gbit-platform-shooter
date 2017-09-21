local Bullet = require("bullet")
local World = require("world")
local g
g = love.graphics
local shootSound = love.audio.newSource("shoot.wav", "static")
shootSound:setVolume(.2)
local Weapon
do
  local _class_0
  local _base_0 = {
    damage = 20,
    bullets = { },
    canShoot = true,
    rateOfFire = {
      time = 0,
      max = .12
    },
    updateRateOfFire = function(self, dt)
      if self.rateOfFire.time < self.rateOfFire.max and not self.canShoot then
        self.rateOfFire.time = self.rateOfFire.time + dt
      else
        self.rateOfFire.time = 0
        self.canShoot = true
      end
    end,
    update = function(self, dt)
      for i = #self.bullets, 1, -1 do
        local b
        b = self.bullets[i]
        local cols, len = b:update(dt)
        local col
        for j = len, 1, -1 do
          col = cols[j]
          if col.other.__class.__name ~= "Player" then
            if col.other.__class.__name == "Enemy" then
              col.other:damage(self.damage)
            end
            World:remove(b)
            table.remove(self.bullets, i)
            break
          end
        end
      end
    end,
    getVariableBulletVectors = function(self, bullet)
      local angle, goalX, goalY
      angle = math.atan2(bullet.dy, bullet.dx) + math.pi
      local randomAngle = math.random(1000 * (angle - self.sprayAngle), 1000 * (angle + self.sprayAngle)) / 1000
      return -bullet.distance * math.cos(randomAngle) + self.x, -bullet.distance * math.sin(randomAngle) + self.y
    end,
    shootBullet = function(self, x, y)
      local bullet
      self.canShoot = false
      self.ammoCount = self.ammoCount - 1
      bullet = Bullet(self.x - self.bulletSize, self.y - self.bulletSize, x - self.bulletSize, y - self.bulletSize, self.bulletSpeed, self.bulletSize, self.bulletSize)
      bullet:calculateDirections()
      bullet.goalX, bullet.goalY = self:getVariableBulletVectors(bullet)
      bullet:calculateDirections()
      self.bullets[#self.bullets + 1] = bullet
      World:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
      if shootSound:isPlaying() then
        shootSound:stop()
        return shootSound:play()
      else
        return shootSound:play()
      end
    end,
    shootAuto = function(self, x, y)
      local targetX, targetY
      targetX = x + 8
      targetY = y + 8
      if love.mouse.isDown(1) and self.canShoot and self.ammoCount > 0 and self.fireControl == "auto" then
        return self:shootBullet(targetX, targetY)
      end
    end,
    shootSemi = function(self, x, y, button)
      if button == 1 and self.canShoot and self.ammoCount > 0 and self.fireControl == "semi" then
        return self:shootBullet(x, y)
      end
    end,
    draw = function(self, x, y)
      g.setColor(255, 255, 255)
      local angle, scale
      scale = .65
      angle = math.atan2(self.y - y, self.x - x) + math.pi
      g.setColor(0, 0, 0)
      if angle < 3 * math.pi / 2 and angle > math.pi / 2 then
        g.draw(self.sprite, self.x, self.y, angle, scale, -scale, self.drawOffset.x, self.drawOffset.y)
      else
        g.draw(self.sprite, self.x, self.y, angle, scale, scale, self.drawOffset.x, self.drawOffset.y)
      end
      return g.print(tostring(self.ammoCount))
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, magazineSize, sprite, audioSource, sprayAngle)
      if sprayAngle == nil then
        sprayAngle = math.pi / 250
      end
      self.x, self.y, self.magazineSize, self.sprite, self.audioSource, self.sprayAngle = x, y, magazineSize, sprite, audioSource, sprayAngle
      self.ammoCount = self.magazineSize
      self.drawOffset = {
        x = self.sprite:getWidth() / 4,
        y = self.sprite:getHeight() / 2
      }
      self.fireControl = "auto"
      self.bulletSpeed = 2700
      self.bulletSize = 6
    end,
    __base = _base_0,
    __name = "Weapon"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Weapon = _class_0
end
return Weapon
