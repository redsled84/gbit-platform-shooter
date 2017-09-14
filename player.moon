Entity = require "entity"
-- Inventory = require "inventory"
{graphics: g, keyboard: k} = love

class Player extends Entity
  -- inventory: Inventory Pistol!, Rifle!, Shotgun!
  moveWithKeys: (dt) =>
    local speed
    speed = 300
    if k.isDown "d"
      @x += speed * dt
    if k.isDown "a"
      @x -= speed * dt
    if k.isDown "s"
      @y += speed * dt
    if k.isDown "w"
      @y -= speed * dt
      --
        

return Player