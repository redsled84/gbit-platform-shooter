local Entity = require("entity")
local World = require("world")
local Level
do
  local _class_0
  local _base_0 = {
    tileSize = 128,
    grid = {
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
        1,
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
      for i = 1, #self.objects do
        local obj
        obj = self.objects[i]
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)
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
            World:add(obj, obj.x, obj.y, obj.width, obj.height)
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
