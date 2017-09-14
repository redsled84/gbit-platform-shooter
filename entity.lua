local g
g = love.graphics
local Entity
do
  local _class_0
  local _base_0 = {
    drawRect = function(self)
      g.setColor(unpack(self.colors))
      return g.rectangle("fill", self.x, self.y, self.width, self.height)
    end,
    updateWithVel = function(self, dt)
      self.x = self.x + (self.vx * dt)
      self.y = self.y + (self.vy * dt)
    end,
    updateWithBump = function(self, dt, foo)
      self.x, self.y = foo(dt, self.x, self.y)
    end,
    updateVelocities = function(self, dt, foo)
      self.vy = foo(dt, self.vx)
    end,
    getCircleCenter = function(self)
      return self.x, self.y
    end,
    getRectCenter = function(self)
      return self.x + self.width / 2, self.y + self.height / 2
    end,
    getFuturePos = function(self, dt)
      return self.x + self.vx * dt, self.y + self.vy * dt
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, vx, vy, width, height, radius, colors)
      if width == nil then
        width = 100
      end
      if height == nil then
        height = 100
      end
      if radius == nil then
        radius = 16
      end
      if colors == nil then
        colors = {
          0,
          0,
          0
        }
      end
      self.x, self.y, self.vx, self.vy, self.width, self.height, self.radius, self.colors = x, y, vx, vy, width, height, radius, colors
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
return Entity
