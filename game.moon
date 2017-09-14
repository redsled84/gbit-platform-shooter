Player = require "player"
player = Player 0, 0

{graphics: g} = love

class Game
  new: (title, dimensions) =>
    love.window.setTitle title
    love.window.setMode dimensions[1], dimensions[2]
    love.graphics.setBackgroundColor 255, 255, 255
  update: (dt) =>
    player\moveWithKeys dt
  draw: =>
    player\drawRect!
  keypressed: (key) =>
    if key == "escape"
      love.event.quit()
    if key == "r"
      love.event.quit("restart")

return Game