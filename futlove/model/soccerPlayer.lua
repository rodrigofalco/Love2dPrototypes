vector = require "hump.vector"

-- Player states/behaiviours 
DefensiveState = require "model.states.defensiveState"
DefensiveClosestToBallState = require "model.states.defensiveClosestToBallState"

OffensiveState = require "model.states.offensiveState"
OffensiveClosestToBallState = require "model.states.offensiveClosestToBallState"
OffensiveWithBallState = require "model.states.offensiveWithBallState"

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
  self.type = 'SoccerPlayer'
  self.currentState = DefensiveState
  return self
end

function SoccerPlayer:init(world, match, team)
  --print("Init:" .. self.name)
  -- physics
  self.body = love.physics.newBody(world, self.pos.x, self.pos.y, "dynamic")
  self.shape = love.physics.newCircleShape(10) --the ball's shape has a radius of 20
  self.fixture = love.physics.newFixture(self.body, self.shape, 5) -- Attach fixture to body and give it a density of 5.
  self.fixture:setRestitution(0.05)
  self.body:setLinearDamping(0.9)
  self.fixture:setUserData(self) -- we get this in the colission callback later

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
  local playerCenter = { x = self.pos.x - 10, y = self.pos.y - 10 }
	-- minus 10 means minus half our image size, in this case, 20px
	love.graphics.draw(self.image, playerCenter.x, playerCenter.y)
  love.graphics.setColor(255, 255, 255, 255)
  if self.number < 10 then
    love.graphics.print(self.number, self.pos.x - 5, playerCenter.y + 3)
  else
    love.graphics.print(self.number, self.pos.x - 8, playerCenter.y + 3)
  end
  love.graphics.setColor(r, g, b, a)

  if PlayerDebugInfoEnabled then
    local x, y = self.body:getLinearVelocity()
    love.graphics.line(self.pos.x, self.pos.y, self.pos.x + x, self.pos.y + y)
    love.graphics.circle( "line", self.pos.x, self.pos.y, 40, 50 )
  end
end

function SoccerPlayer:update(dt)
  -- get position from physics engine
  local x, y = self.body:getPosition()
  -- update our position vector if needed
  if not (x == self.pos.x) or not (y == self.pos.y) then self.pos = vector(x, y) end

  -- IA v0.00002
  if self:isTeamDefending() then
    if (self.team.minBallDistancePlayer == self) then
      -- im the closest to the ball
      self.currentState = DefensiveClosestToBallState
    else
      self.currentState = DefensiveState
    end
    
  else
    -- check if we are in controll of the ball
    if (self.match.currentPlayerWithBall == self) then
      -- I have the ball
      -- im the closest to the ball
      self.currentState = OffensiveWithBallState
    elseif (self.team.minBallDistancePlayer == self) then
      -- im the closest to the ball
      self.currentState = OffensiveClosestToBallState
    else
      self.currentState = OffensiveState
    end
    
  end

  self.currentState.updatePlayerState(dt, self)
  
end

function SoccerPlayer:isTeamDefending()
  return self.match:isTeamDefending(self.team)
end

function SoccerPlayer:moveTo(dt, position, slowdown)

   -- This is the distance and direction
  local distanceVector = position - self.pos
  local distanceMts = distanceVector:len()

  -- only for player 11/Debug
  if (self.index == 10) then
    --print("Player 10 distance to tactical goal:" .. distanceMts)
  end

  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = self.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = self.stats.acceleration * self.match.config.engine.accelarationAdjustment * dt

  if playerSpeed <  ((1 / 10) * self.stats.maxSpeed )then
    if distanceMts > 25 or not slowdown  then
      self.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
    end
    -- or deaccelerate
  end
end

function SoccerPlayer:passBallTo(dt, target)
  print("pass:" .. self.name .. " passes to " .. target.name)
  local targetVelx, targetVely = target.body:getLinearVelocity()
  local targetVector = vector(target.pos.x + targetVelx, target.pos.y + targetVely)
  local distanceVector = targetVector - self.pos
  local normalizedDistanceVector = distanceVector:normalized()
  --normalizedDistanceVector
  local x, y = self.match.ball.body:getPosition()

  self.match.ball.body:setPosition(x + normalizedDistanceVector.x * 20, y + normalizedDistanceVector.y * 20)
  
  self.match.ball.body:setAwake(true)

  self.match.ball.body:applyForce(distanceVector.x * 100 , distanceVector.y * 100)
  self.match.currentPlayerWithBall = nil
end

function SoccerPlayer:shootAtGoal(dt)
  print("shoot:" .. self.name)
  -- get goalie position
  local targetVector = self.rivalsDistance[1].player.pos
  -- the shoot will go towards the goalie, but get a +-5 to it-s Y axis, to go towards the posts
  math.randomseed(os.time())
  local yyskew = math.random(-5,5)
  targetVector.y = targetVector.y + yyskew

  local distanceVector = targetVector - self.pos
  local normalizedDistanceVector = distanceVector:normalized()
  --normalizedDistanceVector
  local x, y = self.match.ball.body:getPosition()

  self.match.ball.body:setPosition(x + normalizedDistanceVector.x * 20, y + normalizedDistanceVector.y * 20)
  
  self.match.ball.body:setAwake(true)

  self.match.ball.body:applyForce(distanceVector.x * 250 , distanceVector.y * 250)
  self.match.currentPlayerWithBall = nil
end

return SoccerPlayer