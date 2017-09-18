local Entity = require("entity")
local World = require("world")
local g, k
do
  local _obj_0 = love
  g, k = _obj_0.graphics, _obj_0.keyboard
end
local collisionFilter
collisionFilter = function(items, other)
  if other.__class.__name == "Bullet" then
    return "cross"
  end
  return "slide"
end
local gravity, terminalVelocity
gravity, terminalVelocity = 2500, 800
local vx, vy, frc, dec, top, low
local acc
frc, acc, dec, top, low = 1400, 1000, 8000, 600, 50
local Player
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    jumpVelocity = -1200,
    onGround = false,
    moveWithKeys = function(self, dt)
      vx, vy = self.vx, self.vy
      if k.isDown('a') then
        if vx > 0 then
          vx = vx - dec * dt
        elseif vx > -top then
          vx = vx - acc * dt
        end
      elseif k.isDown('d') then
        if vx < 0 then
          vx = vx + dec * dt
        elseif vx < top then
          vx = vx + acc * dt
        end
      else
        if math.abs(vx) < low then
          vx = 0
        elseif vx > 0 then
          vx = vx - frc * dt
        elseif vx < 0 then
          vx = vx + frc * dt
        end
      end
      self.vx, self.vy = vx, vy
    end,
    jump = function(self, key)
      if (key == "space" or key == "w") and self.onGround then
        self.vy = self.jumpVelocity
      end
    end,
    updateCollision = function(self, dt)
      local futureX, futureY
      self:updateGravity(dt, gravity, terminalVelocity)
      futureX, futureY = self:getFuturePos(dt)
      local goalX, goalY, cols, len = World:move(self, futureX, futureY, collisionFilter)
      local col
      self.onGround = false
      for i = 1, len do
        col = cols[i]
        if col.other.__class.__name ~= "Bullet" then
          if col.normal.y == -1 or col.normal.y == 1 then
            self.onGround = true
            self.vy = 0
          end
          if col.normal.x == -1 or col.normal.x == 1 then
            self.vx = 0
          end
        end
      end
      self.x, self.y = goalX, goalY
    end,
    draw = function(self, mouseX, mouseY)
      g.setColor(255, 255, 255)
      local angle, x, y
      x, y = self:getCenter()
      angle = math.atan2(y - mouseY, x - mouseX) + math.pi
      if angle < 3 * math.pi / 2 and angle > math.pi / 2 then
        return g.draw(self.sprite, self.x, self.y, 0, -2, 2, self.width / 2)
      else
        return g.draw(self.sprite, self.x, self.y, 0, 2, 2)
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
