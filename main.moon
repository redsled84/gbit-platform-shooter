Game = require "game"

game = Game "Mission JPL3000", {1280, 720}

love.load = ->
  love.update = (dt) ->
    game\update dt
  love.draw = ->
    game\draw!
  love.keypressed = (key) ->
    game\keypressed key
  love.mousepressed = (x, y, button) ->
    game\mousepressed x, y, button