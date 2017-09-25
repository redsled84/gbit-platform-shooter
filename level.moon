Entity = require "entity"
World = require "world"

wallImage = love.graphics.newImage "floor.png"
wallImage\setFilter "nearest", "nearest"
ceilingImage = love.graphics.newImage "ceiling-sprite.png"
ceilingImage\setFilter "nearest", "nearest"

class Level
  tileSize: 128
  grid: {
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1}
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1}
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1}
    {1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1}
    {1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1}
    {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
    {1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
    {1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
  }
  objects: {}
  new: =>
    for y = 1, #@grid
      for x = 1, #@grid[y]
        local n, obj
        n = @grid[y][x]
        if n == 1
          obj = Entity x * @tileSize, y * @tileSize, 0, 0, @tileSize, @tileSize
          @objects[#@objects+1] = obj
  draw: =>
    for y = 1, #@grid
      for x = 1, #@grid[y]
        local n
        n = @grid[y][x]
        if n == 1
          love.graphics.setColor 255, 255, 255
          love.graphics.draw wallImage, x * @tileSize, y * @tileSize, 0, (@tileSize / 32), (@tileSize / 32)
        elseif n == 2
          love.graphics.setColor 255, 255, 255
          love.graphics.draw ceilingImage, x * @tileSize, y * @tileSize, 0, (@tileSize / 32), (@tileSize / 32)

return Level
