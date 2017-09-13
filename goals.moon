-- Ignore this file, more just a thing to write ideas and structure of game out

-- High level overview of dynamic game objects which should all extend an Entity class
--  * Player
--  * Enemy
--  * Bullet
--  * Wall
--  * Ladder
--  * Glass
--  * Explosive Block

-- Now we break stuff down into small sub-components (more like long-term goals)

-- Player
--  * Run right and left
--  * Crouch walk right and left
--  * Shoot selected weapon
--  * Cycle weapons
--  * Small inventory (displayed via HUD)
--  * Health
--  * Jump
--  * Gravity
--  * Ammo capacity

-- Enemy
--  * Behavior tree
--     ** Idle (walk along preset path)
--     ** Suspicious (search area for player then return to preset path if player not found)
--     ** Hostile (try to kill the player)
--  * Walk left and right
--  * Equip one weapon
--  * Dropable equipment on death
--  * Gravity applied
--  * Hop over obstacles
--  * FOV stealth mechanic?

-- Bullet
--  * Dimensions
--  * Velocity vector
--  * Damage constant (could be produced randomly)

-- Wall
--  * Dimensions
--  * Collision emphasis only
--  * Static

-- Ladder
--  * Apply linear velocity upwards on entity moving inwards
--  * Static

-- Glass
--  * Explode on hit
--  * Reduce bullet damage on impact (bullets can go through glass objects)