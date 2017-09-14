local Entity = require("entity")
local g, k
do
  local _obj_0 = love
  g, k = _obj_0.graphics, _obj_0.keyboard
end
local Player
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    moveWithKeys = function(self, dt)
      local speed
      speed = 300
      if k.isDown("d") then
        self.x = self.x + (speed * dt)
      end
      if k.isDown("a") then
        self.x = self.x - (speed * dt)
      end
      if k.isDown("s") then
        self.y = self.y + (speed * dt)
      end
      if k.isDown("w") then
        self.y = self.y - (speed * dt)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Player",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Player = _class_0
end
return Player
