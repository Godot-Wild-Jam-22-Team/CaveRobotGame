# CaveRobotGame
Training game before Godot Wild Jam 22

Environment: Cave
Goal: Survive
Genre: Adventure
Rules: Limited inventory
Wildcard: Robots

The concept as of now

We are an astronaut in cave. We need to escape and survive while we gather all necessary resources to fly away, so we need to collect materials and synthesize oxygen. We can explore the cave (grid based movement) and find resources and we send robots to gather them for us. The astronaut will explore a grid map (top or iso, we need to decide) and when he finds a resource he will assign it to a robot with a path to follow.
The path must take account of robot battery that will reduce for every step, obstacles and light spots where it can recharge. 
Astronaut will have an inventory of missiles to open cracks in the ceiling (light spots), small bombs to remove any debris that could stop robots, gears and batteries to fix robots.

We have to decide if top down or isometric.
Top down is more straightforward, isometric would be a little work intensive for artists and programming could be a little bit more complicate. But it would be nicer.

## Assets we need 

(for each we need different poses according to given style topdown or iso):
Anyway I would stick to 4 directions

### Astronaut: 
- idle, 
- walk, 
- die (no oxygen), 
- hurt (hit by random debris/explosion), 
- repair/action
### Robot: 
- idle, 
- “walk”, 
- die (explosion?), 
- damaged (a small smoke puff could be enough), 
- discharge (but we could do it with color change)

### Tile map:
- cave 
- resource (mineral, ore) -> white with shading then we may change the color with code to assign various meaning
- debris, 
- rock obstacle, 
- light spot overlay, 
- light from crack in the ceiling overlay, 
- base/spaceship, 
- missile, 
- bomb, 
- gear, 
- battery

 ## GUI: 
- battery bar on the top of robot and oxygen for player,  (white so we can color from code)

- (maybe something for statistics)

We may need a small menu for item creation using resources plus inventory.

## SFX list (draft):
- astronaut step sound
- robot step sound (I would like them to have wheels, so an engine would be ok instead of a step)
- explosion for ceiling and rock removed
- debris sound when impact on floor
- small explosion for the robot random break (imagine a small puff of smoke coming out)
- battery charge sound (very sci-fi)
- battery discharge signal (like a small game over)
- sound for repairing the robot (both gears and battery replacement, like rumaging in something full of metallic pieces)
- drop sound for item inventory (?)
