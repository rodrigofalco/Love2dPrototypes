teams = require "teams"
Stadium = require "stadium"
Match = require "match"

local stadium = nil
local match = nil

function love.load()
	-- To see live sublime console.
	io.stdout:setvbuf("no")
	 
  -- Prepare/configure match 
  stadium = Stadium.new({ imageSrc = "resources/soccerField800x600.png" })
  match = Match.new({ team1 = teams.patagonian, team2 = teams.enemies, location = stadium })

  -- load match resources
	match:load()
end

function love.draw()
  -- draw stuff
  -- love.graphics.print("Hello World", 400, 300)
  match:draw()
end

function love.update(dt)
  match:update(dt)
  --[[
   if love.keyboard.isDown("right") then
      x = x + (speed * dt)
   end
   if love.keyboard.isDown("left") then
      x = x - (speed * dt)
   end

   if love.keyboard.isDown("down") then
      y = y + (speed * dt)
   end
   if love.keyboard.isDown("up") then
      y = y - (speed * dt)
   end
   ]]--
end

function love.keypressed(k)

    if k == 'escape' then
        love.event.push('quit') -- quit the game
    end
    if k == 'a' then
      match.isTeam1Attacking = not match.isTeam1Attacking
      match:initPlayerPosition()
    end
    if k == 's' then
      match.isTeam2Attacking = not match.isTeam2Attacking
      match:initPlayerPosition()
    end
    if k == 'p' then
      match.paused = not match.paused
    end
end