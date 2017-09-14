local bump, world, inspect
inspect = require "inspect"

World = require "world"

Player = require "player"
player = Player 0, 0, 0, 0, 32, 72
Entity = require "entity"
entity = Entity 0, 450, 0, 0, 600, 50

World\add player, player.x, player.y, player.width, player.height

World\add entity, entity.x, entity.y, entity.width, entity.height

{graphics: g} = love

class Game
  new: (title, dimensions) =>
    love.window.setTitle title
    love.window.setMode dimensions[1], dimensions[2]
    love.graphics.setBackgroundColor 255, 255, 255
  update: (dt) =>
    player\moveWithKeys dt
    player\updateCollision dt

    -- for i = 1, #items
    --   item = items[i]
    --   g.rectangle("fill", item.x, item.y, item.width, item.height)
  draw: =>
    player\draw!
    entity\draw!

  keypressed: (key) =>
    if key == "escape"
      love.event.quit()
    if key == "r"
      love.event.quit("restart")
    player\jump key

return Game