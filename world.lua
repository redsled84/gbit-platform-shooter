local bump, world
bump = require("bump")
world = bump.newWorld()
local World
do
  local _class_0
  local _base_0 = {
    add = function(self, item, x, y, width, height)
      return world:add(item, x, y, width, height)
    end,
    move = function(self, item, x, y, collisionFilter)
      return world:move(item, x, y, collisionFilter)
    end,
    update = function(self, item, x, y, width, height)
      return world:update(item, x, y, width, height)
    end,
    remove = function(self, item)
      return world:remove(item)
    end,
    getItems = function(self)
      return world:getItems()
    end,
    removeDeadEnemies = function(self)
      local items
      items = self:getItems()
      for i = #items, 1, -1 do
        if items[i].__class.__name == "Enemy" then
          if items[i].health <= 0 then
            items[i].removed = true
            self:remove(items[i])
            items[i] = nil
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "World"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  World = _class_0
  return _class_0
end
