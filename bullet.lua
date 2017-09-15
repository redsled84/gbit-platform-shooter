local World = require("world")
local collisionFilter
collisionFilter = function(items, other)
  if other.__class.__name == "Player" then
    return "cross"
  end
  return "slide"
end
local Bullet
do
  local _class_0
  local _base_0 = {
    calculateDirections = function(self)
      self.dx = self.goalX - self.x
      self.dy = self.goalY - self.y
      self.distance = math.sqrt(math.pow(self.goalX - self.x, 2) + math.pow(self.goalY - self.y, 2))
      self.directionX = (self.dx) / self.distance
      self.directionY = (self.dy) / self.distance
    end,
    update = function(self, dt)
      self.vy = self.vy + (self.bulletDrop * dt)
      local futureX, futureY
      futureX = self.x + self.directionX * self.speed * dt
      futureY = self.y + self.vy + self.directionY * self.speed * dt
      local goalX, goalY, cols, len
      goalX, goalY, cols, len = World:move(self, futureX, futureY, collisionFilter)
      self.x = goalX
      self.y = goalY
      return cols, len
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, goalX, goalY, speed, width, height, damage, bulletDrop)
      if bulletDrop == nil then
        bulletDrop = .1
      end
      self.x, self.y, self.goalX, self.goalY, self.speed, self.width, self.height, self.damage, self.bulletDrop = x, y, goalX, goalY, speed, width, height, damage, bulletDrop
      self.vy = 0
    end,
    __base = _base_0,
    __name = "Bullet"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Bullet = _class_0
end
return Bullet
