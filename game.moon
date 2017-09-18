math.randomseed os.time!

local bump, world, inspect
inspect = require "inspect"

Camera = require "camera"
Level = require "level"
Player = require "player"
Weapon = require "weapon"
World = require "world"

{graphics: g} = love

cam = Camera love.graphics.getWidth! / 2, love.graphics.getHeight! / 2

level1 = Level!

weapon = Weapon 0, 0, 100, g.newImage("m4.png")

playerImage = g.newImage "player.png"
playerImage\setFilter "nearest", "nearest"
player = Player 256, 256, 0, 0, playerImage\getWidth!*2, playerImage\getHeight!*2-4, nil, playerImage
World\add player, player.x, player.y, player.width, player.height

cursorImage = g.newImage "cursor.png"

local mouseX, mouseY

class Game
  new: (title, dimensions) =>
    love.window.setTitle title
    love.window.setMode dimensions[1], dimensions[2]
    g.setBackgroundColor 255, 255, 255
    cursor = love.mouse.newCursor "cursor.png", 0, 0
    love.mouse.setCursor cursor

  update: (dt) =>
    mouseX, mouseY = cam\worldCoords love.mouse.getX!, love.mouse.getY!

    player\moveWithKeys dt
    player\updateCollision dt

    weapon\updateRateOfFire dt
    weapon\update dt
    weapon.x, weapon.y = player\getCenter!
    weapon\shootAuto mouseX, mouseY

    cam\lookAt player.x, player.y

  draw: =>
    cam\attach!

    level1\draw!
    player\draw mouseX, mouseY
    for i = 1, #weapon.bullets
      local b, distance, px, py
      b = weapon.bullets[i]
      px, py = player\getCenter!
      distance = math.sqrt math.pow(px - b.x, 2) + math.pow(py - b.y, 2)
      if distance > 80
        g.setColor 0, 0, 0
        g.rectangle("fill", b.x, b.y, b.width, b.height)
    weapon\draw mouseX, mouseY


    cam\detach!

  keypressed: (key) =>
    if key == "escape"
      love.event.quit()
    if key == "r"
      love.event.quit("restart")
    player\jump key

  mousepressed: (x, y, button) =>
    weapon\shootSemi mouseX, mouseY, button

return Game