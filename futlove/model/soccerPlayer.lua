local SoccerPlayer = {} -- the table representing the class, which will double as the metatable for the instances
SoccerPlayer.__index = SoccerPlayer -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function SoccerPlayer.new(options)
  local self = setmetatable({}, SoccerPlayer)
  self.position = options.pos
  self.number = options.number
  self.name = options.name
  self.image = options.image
  return self
end

function SoccerPlayer:init(world, match, team)
  -- physics
  self.body = love.physics.newBody(world, 0, 0, "dynamic")
  self.shape = love.physics.newCircleShape(10) --the ball's shape has a radius of 20
  self.fixture = love.physics.newFixture(self.body, self.shape, 5) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.05)
  self.fixture:setUserData("Player")

  --print(team.formation)
  self.team = team
  self.isMyTeamLocal = team == match.localTeam
  self:setFormation(team.formation)

end

function SoccerPlayer:setFormation(formation)
  --print(formation)
  self.formation = formation[self.position]
  if(self.body:getX() == 0 and self.body:getY() == 0) then
    -- Initialize player position on the field with the defensive position of the formation object
    -- this should happend only after init.
    if (self.isMyTeamLocal) then
      self.body:setY(self.formation.defense.x)
      self.body:setX(self.formation.defense.y)
    else
      self.body:setY(600 - self.formation.defense.x)
      self.body:setX(800 - self.formation.defense.y)
    end
  end
end

function SoccerPlayer:draw()
	-- minus 10 means minus half our image size, in this case, 20px
	love.graphics.draw(self.image, self.body:getX() - 10, self.body:getY() - 10)
end

function SoccerPlayer:update()
  -- Check tactical desired position from formation + attack/defense mode
  
end

return SoccerPlayer