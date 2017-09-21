local bump, world
bump = require "bump"
world = bump.newWorld!

class World
  add: (item, x, y, width, height) =>
    world\add item, x, y, width, height
  move: (item, x, y, collisionFilter) =>
    world\move item, x, y, collisionFilter 
  update: (item, x, y, width, height) =>
    world\update item, x, y, width, height
  remove: (item) =>
    world\remove item
  getItems: =>
    world\getItems!
  removeDeadEnemies: =>
    local items
    items = @getItems!
    for i = #items, 1, -1
      if items[i].__class.__name == "Enemy"
        if items[i].health <= 0
          items[i].removed = true
          @remove items[i]
          items[i] = nil