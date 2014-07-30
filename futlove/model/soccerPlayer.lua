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
  self.fixture = love.physics.newFixture(self.body, self.shape, 5) -- Attach fixture to body and give it a density of 1.
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
    if (self.team.minBallDistanceIndex == self.index) then
      -- im the closest to the ball
      --self:defendClosestToBall(dt)
      DefensiveClosestToBallState.updatePlayerState(dt, self)
    else
      DefensiveState.updatePlayerState(dt, self)
    end
    
  else
    -- print(self.name .. " is Attacking")
    -- check if we are in controll of the ball
    if (self.match.currentPlayerWithBall == self) then
      -- I have the ball
      -- im the closest to the ball
      OffensiveWithBallState.updatePlayerState(dt, self)
    elseif (self.team.minBallDistanceIndex == self.index) then
      -- im the closest to the ball
      OffensiveClosestToBallState.updatePlayerState(dt, self)
    else
      OffensiveState.updatePlayerState(dt, self)
    end
    
  end
  
end

function SoccerPlayer:isTeamDefending()
  return self.match:isTeamDefending(self.team)
end

return SoccerPlayer