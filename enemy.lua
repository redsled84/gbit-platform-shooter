local inspect = require("inspect")
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
    removed = false,
    movementSequence = function(self)
      return BT:new({
        object = self,
        tree = BT.Sequence:new({
          nodes = {
            BT.Task:new({
              run = function(task, object)
                self.currentGoal = self:getNextGoal()
                return task:success()
              end
            }),
            BT.Sequence:new({
              nodes = {
                BT.Task:new({
                  run = function(task, object)
                    local nextGoal
                    nextGoal = self:getNextGoal()
                    self.dx = nextGoal.x - self.x
                    self.dy = self.y - nextGoal.y
                    return task:success()
                  end
                }),
                BT.Priority:new({
                  nodes = {
                    BT.Sequence:new({
                      nodes = {
                        BT.Task:new({
                          run = function(task, object)
                            if self.dy > 0 then
                              return task:success()
                            else
                              return task:fail()
                            end
                          end
                        }),
                        BT.Task:new({
                          run = function(task, object)
                            self:jump()
                            return task:success()
                          end
                        })
                      }
                    }),
                    BT.Task:new({
                      run = function(task, object)
                        if self.dx > 0 then
                          self.vx = self.walkSpeed
                          return task:success()
                        elseif self.dx < 0 then
                          self.vx = -self.walkSpeed
                          return task:success()
                        else
                          self.vx = 0
                          return task:fail()
                        end
                      end
                    })
                  }
                })
              }
            })
          }
        })
      })
    end,
    getNextGoal = function(self)
      print(self.goalCounter)
      if self.direction > 0 and self.goalCounter + 1 <= #self.goals then
        return self.goals[self.goalCounter + 1]
      end
      self.goalCounter = 1
      return self.goals[self.goalCounter]
    end,
    damage = function(self, amount)
      self.health = self.health - amount < 0 and 0 or self.health - amount
    end,
    update = function(self, dt)
      self:movementSequence():run()
      self:updateGravity(dt, gravity, terminalVelocity)
      if not self.removed then
        local goalX, goalY, cols, len
        goalX, goalY, cols, len = self:getCollisionInfo(dt)
        local col
        self.onGround = false
        for i = 1, len do
          col = cols[i]
          if col.normal.y == 1 or col.normal.y == -1 then
            self.vy = 0
            self.onGround = col.normal.y == -1
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
    jump = function(self)
      if self.onGround then
        self.vy = self.jumpVelocity
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
    __init = function(self, goals, sprite, health, goalCounter)
      if goalCounter == nil then
        goalCounter = 1
      end
      self.goals, self.sprite, self.health, self.goalCounter = goals, sprite, health, goalCounter
      self.currentGoal = self.goals[self.goalCounter]
      self.direction = 1
      self.vx = 100
      self.vy = 0
      self.jumpVelocity = -400
      self.dx = 0
      self.dy = 0
      self.walkSpeed = 100
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
