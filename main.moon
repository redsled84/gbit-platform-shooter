Game = require "game"

game = Game "Mission YoYo", {1280, 720}

love.load = ->
  love.update = (dt) ->
    game\update dt
  love.draw = ->
    game\draw!
  love.keypressed = (key) ->
    game\keypressed key