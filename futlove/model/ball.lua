vector = require "hump.vector"

local Ball = {}
Ball.__index = Ball -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function Ball.new(options)
  local self = setmetatable({}, Ball)
  self.pos = vector(800/2, 600/2)
  self.scaleX = 1
  self.scaleY = 1
  self.rotation = 0
  self.imageSrc = options.imageSrc
  self.type = 'Ball'
  self.status = 'In'
  return self
end

function Ball:init(world)
--let's add ball physics
  self.body = love.physics.newBody(world, self.pos.x, self.pos.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  self.body:setLinearDamping(0.3)
  --self.body:setMass(1) 
  self.shape = love.physics.newCircleShape(5) --the ball's shape has a radius of 20
  self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.2) --let the ball bounce
  self.fixture:setUserData(self) -- we get this in the colission callback later
end

function Ball:load()
  self.image = love.graphics.newImage(self.imageSrc)
end

function Ball:draw()
	-- minus 5 means minus half our image size, in this case, 10px
	love.graphics.draw(self.image, self.pos.x - 5, self.pos.y - 5)
end

function Ball:update(dt)
  -- get position from physics engine
  local x, y = self.body:getPosition()
  -- update our position vector if needed
  if not (x == self.pos.x) or not (y == self.pos.y) then self.pos = vector(x, y) end
end

return Ball