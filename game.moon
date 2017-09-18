math.randomseed os.time!

local bump, world, inspect
inspect = require "inspect"

{graphics: g} = love

World = require "world"

playerImage = g.newImage "player.png"
playerImage\setFilter "nearest", "nearest"
Player = require "player"
player = Player 256, 256, 0, 0, playerImage\getWidth!*2, playerImage\getHeight!*2-4, nil, playerImage
Entity = require "entity"

Camera = require "camera"
cam = Camera(love.graphics.getWidth! / 2, love.graphics.getHeight! / 2)

Weapon = require "weapon"
weapon = Weapon player.x, player.y, 100, g.newImage("m4.png"), nil

World\add player, player.x, player.y, player.width, player.height

Level = require "level"
level1 = Level!

cursorImage = g.newImage "cursor.png"

class Game
  new: (title, dimensions) =>
    love.window.setTitle title
    love.window.setMode dimensions[1], dimensions[2]
    g.setBackgroundColor 255, 255, 255
    cursor = love.mouse.newCursor "cursor.png", 0, 0
    love.mouse.setCursor cursor
  update: (dt) =>
    player\moveWithKeys dt
    player\updateCollision dt
    weapon\updateRateOfFire dt
    weapon\update dt
    weapon.x, weapon.y = player\getCenter!
    weapon\shootAuto!
    cam\lookAt player.x, player.y

  draw: =>
    cam\attach!
    player\draw!
    weapon\draw!
    level1\draw!

    for i = 1, #weapon.bullets
      local b
      b = weapon.bullets[i]
      g.rectangle("fill", b.x, b.y, b.width, b.height)
    cam\detach!

  keypressed: (key) =>
    if key == "escape"
      love.event.quit()
    if key == "r"
      love.event.quit("restart")
    player\jump key

  mousepressed: (x, y, button) =>
    weapon\shootSemi x + cursorImage\getWidth! / 2, y + cursorImage\getHeight! / 2, button

return Game