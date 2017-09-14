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
      local distance
      distance = math.sqrt(math.pow(self.goalX - self.x, 2) + math.pow(self.goalY - self.y, 2))
      self.directionX = (self.goalX - self.x) / distance
      self.directionY = (self.goalY - self.y) / distance
    end,
    update = function(self, dt)
      local futureX, futureY
      futureX = self.x + self.directionX * self.speed * dt
      futureY = self.y + self.directionY * self.speed * dt
      local goalX, goalY, cols, len
      goalX, goalY, cols, len = World:move(self, futureX, futureY, collisionFilter)
      self.x = goalX
      self.y = goalY
      return cols, len
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, goalX, goalY, speed, width, height, damage)
      self.x, self.y, self.goalX, self.goalY, self.speed, self.width, self.height, self.damage = x, y, goalX, goalY, speed, width, height, damage
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
