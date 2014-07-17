local Match = {} -- the table representing the class, which will double as the metatable for the instances
Match.__index = Match -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "Match.new = function..."
function Match.new(options)
  local self = setmetatable({}, Match)
  self.paused = true
  self.matchSpeed = 2 -- twice as fast
  self.minutes = 0
  self.seconds = 0
  self.milis = 0
  self.team1 = options.team1
  self.team2 = options.team2
  self.stadium = options.stadium
  self.ball = options.ball


  
  -- Local team starts the match with the ball
	self.localTeam = self.team1
  self.attackingTeam = self.team1

  return self
end

function Match:load()
	-- Physics engine init
	-- 6,7px is 1 meter in our world
  love.physics.setMeter(6.7)
   --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 0 -- 9.81 earth gravity
  world = love.physics.newWorld(0, 0, true)
  objects = {} -- table to hold all our physical objects

  -- stadium init
	self.stadium:load() -- TODO add physics to stadium, colliders on borders?

  -- ball init
	self.ball:load()
	self.ball:init(world)
  objects.ball = self.ball

  -- players init
	self:initPlayers(world, objects)

	-- initial ball kick off
	-- If we do a vector operation substracting the ball position from the player pos
	-- we obtain the vector from the ball to the player.
	-- http://www.blancmange.info/notes/maths/vectors/ops/
	-- Choose team 11th player as target
	local targetPositionVector = self.attackingTeam.players[11].pos
	self:initKickoff(self.attackingTeam.players[11])
end

function Match:initKickoff(player)
	local directionVector = player.pos - self.ball.pos
	--print(directionVector)
	--self.ball.body:applyForce(-10000, -10000)
	self.ball.body:applyForce(directionVector.x * 100, directionVector.y * 100)
end


function Match:initPlayers(world, objects)
	for i=1, 11 do 
		self.team1.players[i]:init(world, self, self.team1)
		self.team2.players[i]:init(world, self, self.team2)
	end
end

function Match:draw()
	self.stadium:draw()
	-- Players
	for i=1, 11 do
		self.team1.players[i]:draw()
		self.team2.players[i]:draw()
	end 
	-- Ball
	self.ball:draw()

	-- GUI - TODO move to scene
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 0, 0, 255)
	local playState = "play"
	if (not self.paused) then playState = "paused" end
	love.graphics.print(string.format('Match time %2d:%2d:%3d.\nPress "p" to %s', self.minutes, self.seconds, self.milis, playState), 70, 10)
	love.graphics.setColor(r, g, b, a)
end

function Match:update(dt)
	if not self.paused then
		world:update(dt)
		self.milis = self.milis + dt * 1000 * self.matchSpeed
		while self.milis > 999 do
			self.milis = self.milis - 1000
			self.seconds = self.seconds + 1
		end
		while self.seconds > 59  do
			self.seconds = self.seconds - 60
			self.minutes = self.minutes + 1
		end
		self.stadium:update(dt)
		self.ball:update(dt)

		-- precalculate some stuff, like distance from each player to the ball.
		self:preCalculatePlayerData(dt)
		for i=1, 11 do
			self.team1.players[i]:update(dt)
			self.team2.players[i]:update(dt)
		end 
	end 

end

function Match:preCalculatePlayerData(dt)
	self.team1.minBallDistance = 9999999999999
  self.team2.minBallDistance = 9999999999999
	for i=1, 11 do
		--print("#11 " .. self.team1.players[i].pos.x)
		--print("#12 " .. self.ball.pos.x)
		self.team1.players[i].ballDistance = (self.team1.players[i].pos - self.ball.pos):len()
		--print("#13 " .. self.team1.players[i].ballDistance)
		--print("#14 " .. self.team1.minBallDistance)
		if (self.team1.players[i].ballDistance < self.team1.minBallDistance) then
			self.team1.minBallDistance = self.team1.players[i].ballDistance
			self.team1.minBallDistanceIndex = i
		end
		self.team2.players[i].ballDistance = (self.team2.players[i].pos - self.ball.pos):len()
		if (self.team2.players[i].ballDistance < self.team2.minBallDistance) then
			self.team2.minBallDistance = self.team2.players[i].ballDistance
			self.team2.minBallDistanceIndex = i
		end
	end 

	print("T1:" .. self.team1.players[self.team1.minBallDistanceIndex].name)
	print("T2:" .. self.team2.players[self.team2.minBallDistanceIndex].name)

end

function Match:isTeamDefending(team)
	return not (self.attackingTeam == team)
end

return Match