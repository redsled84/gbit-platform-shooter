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
    shoot = function(self, x, y, button, world)
      if button == 1 and self.canShoot and self.ammoCount > 0 then
        local bullet
        self.canShoot = false
        self.ammoCount = self.ammoCount - 1
        bullet = Bullet(self.x, self.y, x, y, 1000, 12, 12)
        bullet:calculateDirections()
        self.bullets[#self.bullets + 1] = bullet
        return World:add(bullet, bullet.x, bullet.y, bullet.width, bullet.height)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, magazineSize, accuracy)
      if accuracy == nil then
        accuracy = 1
      end
      self.x, self.y, self.magazineSize, self.accuracy = x, y, magazineSize, accuracy
      self.ammoCount = self.magazineSize
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
