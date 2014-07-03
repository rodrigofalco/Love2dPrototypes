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
  self.location = options.location
  self.isTeam1Attacking = false
  self.isTeam2Attacking = false
  -- Local team, may be team11, team2, or none (like world cup)
  -- self.localTeam = options.localTeam
  -- self.image = options["image"]

  return self
end

function Match:load()
	self.location:load()
	self:initPlayerPosition()
end

function Match:initPlayerPosition()
	for i=1, 11 do 
		if self.isTeam1Attacking then
			self.team1.players[i].y = self.team1.formation[i].attack.x
			self.team1.players[i].x = self.team1.formation[i].attack.y
		else
			self.team1.players[i].y = self.team1.formation[i].defense.x
			self.team1.players[i].x = self.team1.formation[i].defense.y
		end

		-- in the second team, the formation position is inverted
		if self.isTeam2Attacking then
			self.team2.players[i].y = 600 - self.team2.formation[i].attack.x
			self.team2.players[i].x = 800 - self.team2.formation[i].attack.y
		else
			self.team2.players[i].y = 600 - self.team2.formation[i].defense.x
			self.team2.players[i].x = 800 - self.team2.formation[i].defense.y
		end

	end
end

function Match:draw()
	self.location:draw()

	-- GUI
	r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 0, 0, 255)
	local playState = "play"
	if (not self.paused) then playState = "paused" end
	love.graphics.print(string.format('Match time %2d:%2d:%3d.\nPress "p" to %s', self.minutes, self.seconds, self.milis, playState), 70, 10)
	love.graphics.setColor(r, g, b, a)
	for i=1, 11 do
		self.team1.players[i]:draw()
		self.team2.players[i]:draw()
	end 
end

function Match:update(dt)
	if not self.paused then
		self.milis = self.milis + dt * 1000 * self.matchSpeed
		while self.milis > 999 do
			self.milis = self.milis - 1000
			self.seconds = self.seconds + 1
		end
		while self.seconds > 59  do
			self.seconds = self.seconds - 60
			self.minutes = self.minutes + 1
		end

		self.location:update()
	end
end

return Match