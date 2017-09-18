local Game = require("game")
local game = Game("Mission JPL3000", {
  1280,
  720
})
love.load = function()
  love.update = function(dt)
    return game:update(dt)
  end
  love.draw = function()
    return game:draw()
  end
  love.keypressed = function(key)
    return game:keypressed(key)
  end
  love.mousepressed = function(x, y, button)
    return game:mousepressed(x, y, button)
  end
end
