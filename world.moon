local bump, world
bump = require "bump"
world = bump.newWorld!

class World
  entities: {}
  getGroup: (className) =>
    local group
    group = {}
    for i = #@entities, 1, -1
      if @entities[i].__class.__name == className
        group[#group+1] = @entities[i]
    return group
  add: (item, x, y, width, height) =>
    world\add item, x, y, width, height
    @entities[#@entities+1] = item
  move: (item, x, y, collisionFilter) =>
    world\move item, x, y, collisionFilter 
  update: (item, x, y, width, height) =>
    world\update item, x, y, width, height
  remove: (item) =>
    world\remove item