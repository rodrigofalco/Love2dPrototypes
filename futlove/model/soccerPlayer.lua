vector = require "hump.vector"

local accelarationAdjustment = 30000

local SoccerPlayer = {} -- the table representing the class, which will double as the metatable for the instances
SoccerPlayer.__index = SoccerPlayer -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function SoccerPlayer.new(options)
  --print("new:" .. options.name)
  local self = setmetatable({}, SoccerPlayer)
  self.index = options.index -- player position in team 1-11 playing
  self.pos = vector(0, 0)
  self.number = options.number
  self.name = options.name
  self.image = options.image
  self.stats = options.stats or { maxSpeed = 5.0, acceleration = 5.0 }
  return self
end

function SoccerPlayer:init(world, match, team)
  --print("Init:" .. self.name)
  -- physics
  self.body = love.physics.newBody(world, self.pos.x, self.pos.y, "dynamic")
  self.shape = love.physics.newCircleShape(10) --the ball's shape has a radius of 20
  self.fixture = love.physics.newFixture(self.body, self.shape, 5) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.05)
  self.body:setLinearDamping(0.9)
  self.fixture:setUserData("Player")

  self.match = match
  self.team = team
  self.isMyTeamLocal = (team == match.localTeam)
  self:setFormation(team.formation)

end

function SoccerPlayer:setFormation(formation)
  --print(self.index)
  -- Formation has the entire team formation. Extract this player position
  self.formation = formation[self.index]
  if(self.body:getX() == 0 and self.body:getY() == 0) then
    -- Initialize player position on the field with the defensive position of the formation object
    -- this should happend only after init.
    
    if (self.isMyTeamLocal) then
      self.pos = vector(self.formation.defense.y, self.formation.defense.x)
    else
      self.pos = vector(800 - self.formation.defense.y, 600 - self.formation.defense.x)
    end
    self.body:setX(self.pos.x)
    self.body:setY(self.pos.y)
  end
end

function SoccerPlayer:draw()
	-- minus 10 means minus half our image size, in this case, 20px
	love.graphics.draw(self.image, self.pos.x - 10, self.pos.y - 10)
end

function SoccerPlayer:update(dt)
  -- get position from physics engine
  local x, y = self.body:getPosition()
  -- update our position vector if needed
  if not (x == self.pos.x) or not (y == self.pos.y) then self.pos = vector(x, y) end

  -- IA v0.000001

  if self:isTeamDefending() then
    -- print(self.name .. " is Defending")
    self:defend(dt)
  else
    -- print(self.name .. " is Attacking")
    -- see if we are the closer to the ball.
    if (self.team.minBallDistanceIndex == self.index) then
      -- im the closest to the ball
      self:attackClosestToBall(dt)
    else
      self:attackNoBall(dt)
    end
    
  end

end

function SoccerPlayer:isTeamDefending()
  return self.match:isTeamDefending(self.team)
end

-- move and play as defender
function SoccerPlayer:defend(dt)
  -- defending means moveing towards the ideal defensive position, the one in the formation.defense object
  local tacticalPosition = vector(self.formation.defense.y, self.formation.defense.x)
  if (not self.isMyTeamLocal) then
    tacticalPosition = vector(800 - self.formation.defense.y, 600 - self.formation.defense.x)
  end

   -- This is the distance and direction
  local distanceVector = tacticalPosition - self.pos
  local distanceMts = distanceVector:len()

  -- only for player 11
  if (self.index == 10) then
    --print("Player 10 distance to tactical goal:" .. distanceMts)
  end

  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = self.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = self.stats.acceleration * accelarationAdjustment * dt

  if playerSpeed <  ((1 / 10) * self.stats.maxSpeed ) and distanceMts > 30 then
    self.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
  end

  
end

-- move and play as attacker
function SoccerPlayer:attackNoBall(dt)
  -- attacking means moveing towards the ideal attacking position, the one in the formation.attack object
  local tacticalPosition = vector(self.formation.attack.y, self.formation.attack.x)
  if (not self.isMyTeamLocal) then
    tacticalPosition = vector(800 - self.formation.attack.y, 600 - self.formation.attack.x)
  end

   -- This is the distance and direction
  local distanceVector = tacticalPosition - self.pos
  local distanceMts = distanceVector:len()

  -- only for player 11
  if (self.index == 10) then
    --print("Player 10 distance to tactical goal:" .. distanceMts)
  end

  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = self.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = self.stats.acceleration * accelarationAdjustment * dt

  if playerSpeed <  ((1 / 10) * self.stats.maxSpeed ) and distanceMts > 30 then
    self.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
  end
  
end

function SoccerPlayer:attackClosestToBall(dt)
  -- This is the distance and direction
  local distanceVector = self.match.ball.pos - self.pos
  local distanceMts = distanceVector:len()
  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = self.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = self.stats.acceleration * accelarationAdjustment * dt

  print(distanceMts)
  if (distanceMts > 20) then
    -- go to the ball
    if playerSpeed <  ((1 / 10) * self.stats.maxSpeed ) then
      self.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
    end
  else 
    -- ball is in reach
    --self.match.ball.body:setLinearVelocity(0, 0)
    --self.body:setLinearVelocity(0, 0)
  end
end

return SoccerPlayer