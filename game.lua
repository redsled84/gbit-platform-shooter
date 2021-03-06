math.randomseed(os.time())
local bump, world, inspect
inspect = require("inspect")
local Camera = require("camera")
local Enemy = require("enemy")
local Level = require("level")
local Player = require("player")
local Weapon = require("weapon")
local World = require("world")
local g
g = love.graphics
local cursorImage = g.newImage("cursor.png")
local playerImage = g.newImage("player.png")
playerImage:setFilter("nearest", "nearest")
local enemyImage = g.newImage("enemy.png")
enemyImage:setFilter("nearest", "nearest")
local cam = Camera(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
local level1 = Level()
local enemy = Enemy({
  {
    x = 400,
    y = 510
  },
  {
    x = 600,
    y = 510
  },
  {
    x = 700,
    y = 510
  }
}, enemyImage, 50)
local weapon = Weapon(0, 0, 100, g.newImage("m4.png"))
local player = Player(256, 256, 0, 0, playerImage:getWidth() * 2, playerImage:getHeight() * 2 - 4, nil, playerImage)
local mouseX, mouseY
local Game
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      mouseX, mouseY = cam:worldCoords(love.mouse.getX(), love.mouse.getY())
      player:moveWithKeys(dt)
      player:updateCollision(dt)
      enemy:update(dt)
      weapon:updateRateOfFire(dt)
      weapon:update(dt)
      weapon.x, weapon.y = player:getCenter()
      weapon:shootAuto(mouseX, mouseY)
      World:removeDeadEnemies()
      return cam:lookAt(player.x, player.y)
    end,
    draw = function(self)
      cam:attach()
      level1:draw()
      player:draw(mouseX, mouseY)
      for i = 1, #weapon.bullets do
        local b, distance, px, py
        b = weapon.bullets[i]
        px, py = player:getCenter()
        distance = math.sqrt(math.pow(px - b.x, 2) + math.pow(py - b.y, 2))
        if distance > 60 then
          g.setColor(0, 0, 0)
          g.rectangle("fill", b.x, b.y, b.width, b.height)
        end
      end
      weapon:draw(mouseX, mouseY)
      g.setColor(255, 0, 0)
      enemy:draw()
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
      return weapon:shootSemi(mouseX, mouseY, button)
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
