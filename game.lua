local bump, world, inspect
inspect = require("inspect")
local World = require("world")
local Player = require("player")
local player = Player(0, 0, 0, 0, 32, 72)
local Entity = require("entity")
local entity = Entity(0, 450, 0, 0, 600, 50)
World:add(player, player.x, player.y, player.width, player.height)
World:add(entity, entity.x, entity.y, entity.width, entity.height)
local g
g = love.graphics
local Game
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      player:moveWithKeys(dt)
      return player:updateCollision(dt)
    end,
    draw = function(self)
      player:draw()
      return entity:draw()
    end,
    keypressed = function(self, key)
      if key == "escape" then
        love.event.quit()
      end
      if key == "r" then
        love.event.quit("restart")
      end
      return player:jump(key)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, title, dimensions)
      love.window.setTitle(title)
      love.window.setMode(dimensions[1], dimensions[2])
      return love.graphics.setBackgroundColor(255, 255, 255)
    end,
    __base = _base_0,
    __name = "Game"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Game = _class_0
end
return Game
