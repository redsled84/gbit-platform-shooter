math.randomseed os.time!

local bump, world, inspect
inspect = require "inspect"

{graphics: g} = love

World = require "world"

playerImage = g.newImage "player.png"
playerImage\setFilter "nearest", "nearest"
Player = require "player"
player = Player 0, 0, 0, 0, playerImage\getWidth!*2, playerImage\getHeight!*2-4, nil, playerImage
Entity = require "entity"
entity = Entity 0, 450, 0, 0, 600, 50
entity2 = Entity 600, 200, 0, 0, 50, 150

Weapon = require "weapon"
weapon = Weapon player.x, player.y, 100, g.newImage("m4.png"), nil

World\add player, player.x, player.y, player.width, player.height
World\add entity, entity.x, entity.y, entity.width, entity.height
World\add entity2, entity2.x, entity2.y, entity2.width, entity2.height

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

  draw: =>
    player\draw!
    weapon\draw!
    entity\draw!
    entity2\draw!

    for i = 1, #weapon.bullets
      local b
      b = weapon.bullets[i]
      g.rectangle("fill", b.x, b.y, b.width, b.height)

  keypressed: (key) =>
    if key == "escape"
      love.event.quit()
    if key == "r"
      love.event.quit("restart")
    player\jump key

  mousepressed: (x, y, button) =>
    weapon\shootSemi x + cursorImage\getWidth! / 2, y + cursorImage\getHeight! / 2, button

return Game