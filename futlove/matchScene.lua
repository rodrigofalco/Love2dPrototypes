teams = require "teams"
Stadium = require "model.stadium"
Match = require "model.match"
Ball = require "model.ball"

local matchScene = {
}

PlayerDebugInfoEnabled = true
SoccerFieldDebugInfoEnabled = true

function matchScene:init()
  --print("matchScene:init")
  matchScene.stadium = Stadium.new({ imageSrc = "resources/soccerField800x600.png"})
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
  -- print("matchScene:enter")
end

function matchScene:load()
  
end

function matchScene:keyreleased(k, code)
  if k == 'escape' then
   love.event.push('quit') -- quit the game
  elseif k == 'p' then
    matchScene.match.paused = not matchScene.match.paused
  elseif k == 'a' then
    matchScene.match.attackingTeam = matchScene.match.team1
    --matchScene.match:initPlayerPosition()
  elseif k == 's' then
    matchScene.match.attackingTeam = matchScene.match.team2
    --matchScene.match:initPlayerPosition()
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