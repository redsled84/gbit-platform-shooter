math.randomseed os.time!

local bump, world, inspect
inspect = require "inspect"

World = require "world"

Player = require "player"
player = Player 0, 0, 0, 0, 32, 140
Entity = require "entity"
entity = Entity 0, 450, 0, 0, 600, 50

Weapon = require "weapon"
weapon = Weapon player.x, player.y, 100

World\add player, player.x, player.y, player.width, player.height
World\add entity, entity.x, entity.y, entity.width, entity.height

{graphics: g} = love

playerImage = g.newImage("Untitled-2.png")
playerImage\setFilter("nearest", "nearest")

class Game
  new: (title, dimensions) =>
    love.window.setTitle title
    love.window.setMode dimensions[1], dimensions[2]
    love.graphics.setBackgroundColor 255, 255, 255
  update: (dt) =>
    player\moveWithKeys dt
    player\updateCollision dt
    weapon\updateRateOfFire dt
    weapon\update dt
    weapon.x, weapon.y = player\getCenter!

    -- for i = 1, #items
    --   item = items[i]
    --   g.rectangle("fill", item.x, item.y, item.width, item.height)
  draw: =>
    love.graphics.setColor(255,255,255)
    g.draw(playerImage, player.x, player.y, 0, 2)
    entity\draw!

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
    weapon\shoot x, y, button

return Game