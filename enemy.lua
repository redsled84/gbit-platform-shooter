local BT = require("lib.behaviour_tree")
local Entity = require("entity")
local World = require("world")
local gravity, terminalVelocity
gravity = 1000
terminalVelocity = 750
local Enemy
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    getNextGoal = function(self) end,
    removed = false,
    damage = function(self, amount)
      self.health = self.health - amount < 0 and 0 or self.health - amount
    end,
    movementSequence = BT:new({
      object = self,
      tree = BT.Sequence:new({
        nodes = { }
      })
    }),
    update = function(self, dt)
      self:updateGravity(dt, gravity, terminalVelocity)
      if not self.removed then
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
      end
    end,
    draw = function(self)
      if not self.removed then
        love.graphics.setColor(unpack(self.colors))
        return love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, goals, sprite, health)
      self.goals, self.sprite, self.health = goals, sprite, health
      self.currentGoal = self.goals[1]
      self.goalCounter = 1
      self.direction = 1
      self.vx = 100
      return _class_0.__parent.__init(self, self.currentGoal.x, self.currentGoal.y, nil, nil, self.sprite:getWidth(), self.sprite:getHeight() * 2, {
        255,
        255,
        255
      }, self.sprite)
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
