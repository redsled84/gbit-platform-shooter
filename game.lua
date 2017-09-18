math.randomseed(os.time())
local bump, world, inspect
inspect = require("inspect")
local g
g = love.graphics
local World = require("world")
local playerImage = g.newImage("player.png")
playerImage:setFilter("nearest", "nearest")
local Player = require("player")
local player = Player(256, 256, 0, 0, playerImage:getWidth() * 2, playerImage:getHeight() * 2 - 4, nil, playerImage)
local Entity = require("entity")
local Camera = require("camera")
local cam = Camera(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
local Weapon = require("weapon")
local weapon = Weapon(player.x, player.y, 100, g.newImage("m4.png"), nil)
World:add(player, player.x, player.y, player.width, player.height)
local Level = require("level")
local level1 = Level()
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
      weapon:shootAuto()
      return cam:lookAt(player.x, player.y)
    end,
    draw = function(self)
      cam:attach()
      player:draw()
      weapon:draw()
      level1:draw()
      for i = 1, #weapon.bullets do
        local b
        b = weapon.bullets[i]
        g.rectangle("fill", b.x, b.y, b.width, b.height)
      end
      return cam:detach()
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
      return weapon:shootSemi(x + cursorImage:getWidth() / 2, y + cursorImage:getHeight() / 2, button)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, title, dimensions)
      love.window.setTitle(title)
      love.window.setMode(dimensions[1], dimensions[2])
      g.setBackgroundColor(255, 255, 255)
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
