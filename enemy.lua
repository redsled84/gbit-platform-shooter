local BT = require("lib.behaviour_tree")
local Entity = require("entity")
local gravity, terminalVelocity
gravity = 1000
terminalVelocity = 750
local Enemy
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    movementSequence = function(self) end,
    update = function(self, dt)
      self:updateGravity(dt, gravity, terminalVelocity)
      local goalX, goalY, cols, len
      goalX, goalY, cols, len = self:getCollisionInfo(dt)
      local col
      for i = 1, len do
        col = cols[i]
        if col.normal.y == 1 or col.normal.y == -1 then
          self.vy = 0
        end
        if col.normal.x == 1 then
          self.vx = 100
        elseif col.normal.x == -1 then
          self.vx = -100
        end
      end
      self.x, self.y = goalX, goalY
    end,
    damage = function(self, amount)
      if self.health - amount < 0 then
        self.health = 0
      else
        self.health = self.health - amount
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, goals, sprite)
      self.goals, self.sprite = goals, sprite
      local x, y
      x, y = self.goals[1].x, self.goals[1].y
      _class_0.__parent.__init(self, x, y, nil, nil, self.sprite:getWidth(), self.sprite:getHeight(), nil, self.sprite)
      self.vx = 100
      self.health = 100
    end,
    __base = _base_0,
    __name = "Enemy",
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
  Enemy = _class_0
  return _class_0
end
