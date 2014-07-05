local Ball = {}
Ball.__index = Ball -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function Ball.new(options)
  local self = setmetatable({}, Ball)
  self.value = init
  self.scaleX = 1
  self.scaleY = 1
  self.rotation = 0
  self.imageSrc = options.imageSrc
  return self
end

function Ball:init(world)
--let's add ball physics
  self.body = love.physics.newBody(world, 800/2, 600/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
  self.body:setLinearDamping(0.3)
  --self.body:setMass(1) 
  self.shape = love.physics.newCircleShape(5) --the ball's shape has a radius of 20
  self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.5) --let the ball bounce
  self.fixture:setUserData("Ball")
end

function Ball:load()
  self.image = love.graphics.newImage(self.imageSrc)
end

function Ball:draw()
	-- minus 5 means minus half our image size, in this case, 10px
	love.graphics.draw(self.image, self.body:getX() - 5, self.body:getY() - 5)
end

function Ball:update()
end

return Ball