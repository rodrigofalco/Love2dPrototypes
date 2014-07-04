teams = require "teams"
Stadium = require "model.stadium"
Match = require "model.match"
Ball = require "model.ball"

local matchScene = {
}

function matchScene:init()
  print("matchScene:init")
  matchScene.stadium = Stadium.new({ imageSrc = "resources/soccerField800x600.png" })
  matchScene.ball = Ball.new({ imageSrc = "resources/brazuca2.png" })
  matchScene.match = Match.new({ 
      team1 = teams.patagonian, 
      team2 = teams.enemies, 
      stadium = matchScene.stadium, 
      ball = matchScene.ball 
  })
  matchScene.match:load()
end

function matchScene:enter(previous)
  print("matchScene:enter")
end

function matchScene:load()
  --[[
  love.physics.setMeter(64) --In our world 1 meter equals 64px
  world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

  objects = {} -- table to hold all our physical objects
  --]]
end

function matchScene:keyreleased(k, code)
  if k == 'escape' then
   love.event.push('quit') -- quit the game
  elseif k == 'p' then
    matchScene.match.paused = not matchScene.match.paused
  elseif k == 'a' then
    matchScene.match.isTeam1Attacking = not matchScene.match.isTeam1Attacking
    matchScene.match:initPlayerPosition()
  elseif k == 's' then
    matchScene.match.isTeam2Attacking = not matchScene.match.isTeam2Attacking
    matchScene.match:initPlayerPosition()
  end
	--[[
    if key == 'enter' then
        Gamestate.switch(game)
    end
	--]]
end


function matchScene:update(dt)
  matchScene.match:update(dt)
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

function matchScene:draw()
    matchScene.match:draw()
end



return matchScene