math.randomseed(os.time())
local bump, world, inspect
inspect = require("inspect")
local g
g = love.graphics
local World = require("world")
local Player = require("player")
local player = Player(0, 0, 0, 0, 32, 140)
local Entity = require("entity")
local entity = Entity(0, 450, 0, 0, 600, 50)
local Weapon = require("weapon")
local weapon = Weapon(player.x, player.y, 100, g.newImage("m4.png"), nil)
World:add(player, player.x, player.y, player.width, player.height)
World:add(entity, entity.x, entity.y, entity.width, entity.height)
local playerImage = g.newImage("player.png")
playerImage:setFilter("nearest", "nearest")
local cursorImage = g.newImage("cursor.png")
local Game
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      player:moveWithKeys(dt)
      player:updateCollision(dt)
      weapon:updateRateOfFire(dt)
      weapon:update(dt)
      weapon.x, weapon.y = player:getCenter()
    end,
    draw = function(self)
      love.graphics.setColor(255, 255, 255)
      g.draw(playerImage, player.x, player.y, 0, 2)
      weapon:draw()
      entity:draw()
      for i = 1, #weapon.bullets do
        local b
        b = weapon.bullets[i]
        g.rectangle("fill", b.x, b.y, b.width, b.height)
      end
    end,
    keypressed = function(self, key)
      if key == "escape" then
        love.event.quit()
      end
      if key == "r" then
        love.event.quit("restart")
      end
      return player:jump(key)
    end,
    mousepressed = function(self, x, y, button)
      return weapon:shoot(x + cursorImage:getWidth() / 2, y + cursorImage:getHeight() / 2, button)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, title, dimensions)
      love.window.setTitle(title)
      love.window.setMode(dimensions[1], dimensions[2])
      love.graphics.setBackgroundColor(255, 255, 255)
      local cursor = love.mouse.newCursor("cursor.png", 0, 0)
      return love.mouse.setCursor(cursor)
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
