local Entity = require("entity")
local World = require("world")
local wallImage = love.graphics.newImage("floor.png")
wallImage:setFilter("nearest", "nearest")
local ceilingImage = love.graphics.newImage("ceiling-sprite.png")
ceilingImage:setFilter("nearest", "nearest")
local Level
do
  local _class_0
  local _base_0 = {
    tileSize = 128,
    grid = {
      {
        1,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        2,
        1
      },
      {
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        1
      },
      {
        1,
        1,
        0,
        1,
        1,
        1,
        0,
        0,
        0,
        1,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        1
      },
      {
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1
      }
    },
    objects = { },
    draw = function(self)
      for y = 1, #self.grid do
        for x = 1, #self.grid[y] do
          local n
          n = self.grid[y][x]
          if n == 1 then
            love.graphics.setColor(255, 255, 255)
            love.graphics.draw(wallImage, x * self.tileSize, y * self.tileSize, 0, (self.tileSize / 32), (self.tileSize / 32))
          elseif n == 2 then
            love.graphics.setColor(255, 255, 255)
            love.graphics.draw(ceilingImage, x * self.tileSize, y * self.tileSize, 0, (self.tileSize / 32), (self.tileSize / 32))
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      for y = 1, #self.grid do
        for x = 1, #self.grid[y] do
          local n, obj
          n = self.grid[y][x]
          if n == 1 then
            obj = Entity(x * self.tileSize, y * self.tileSize, 0, 0, self.tileSize, self.tileSize)
            self.objects[#self.objects + 1] = obj
          end
        end
      end
    end,
    __base = _base_0,
    __name = "Level"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Level = _class_0
end
return Level
