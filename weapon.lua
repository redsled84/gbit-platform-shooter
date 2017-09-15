local Bullet = require("bullet")
local World = require("world")
local Weapon
do
  local _class_0
  local _base_0 = {
    canShoot = true,
    rateOfFire = {
      time = 0,
      max = .1
    },
    updateRateOfFire = function(self, dt)
      if self.rateOfFire.time < self.rateOfFire.max and not self.canShoot then
        self.rateOfFire.time = self.rateOfFire.time + dt
      else
        self.rateOfFire.time = 0
        self.canShoot = true
      end
    end,
    bullets = { },
    update = function(self, dt)
      for i = #self.bullets, 1, -1 do
        local b
        b = self.bullets[i]
        local cols, len = b:update(dt)
        local col
        for j = len, 1, -1 do
          col = cols[j]
          if col.other.__class.__name ~= "Player" then
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
    shoot = function(self, x, y, button, world)
      if button == 1 and self.canShoot and self.ammoCount > 0 then
        local bullet, bulletSize
        self.canShoot = false
        self.ammoCount = self.ammoCount - 1
        bulletSize = 8
        bullet = Bullet(self.x, self.y, x - bulletSize, y - bulletSize, 1000, bulletSize, bulletSize)
        bullet:calculateDirections()
        bullet.goalX, bullet.goalY = self:getVariableBulletVectors(bullet)
        bullet:calculateDirections()
        self.bullets[#self.bullets + 1] = bullet
        return World:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
      end
    end,
    draw = function(self)
      love.graphics.setColor(255, 255, 255)
      return love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, self.drawOffset.x, self.drawOffset.y)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, magazineSize, sprite, audioSource, sprayAngle)
      if sprayAngle == nil then
        sprayAngle = math.pi / 300
      end
      self.x, self.y, self.magazineSize, self.sprite, self.audioSource, self.sprayAngle = x, y, magazineSize, sprite, audioSource, sprayAngle
      self.ammoCount = self.magazineSize
      self.drawOffset = {
        x = self.sprite:getWidth() / 4,
        y = self.sprite:getHeight() / 2
      }
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
