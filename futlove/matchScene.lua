teams = require "teams"
Stadium = require "model.stadium"
Match = require "model.match"
Ball = require "model.ball"

local matchScene = {
--[[
	match = Match.new({
		team1 = teams.patagonian,
		team2 = teams.enemies,
		stadium = Stadium.new({ imageSrc = "resources/soccerField800x600.png" }),
		ball = Ball.new({ imageSrc = "resources/brazuca2.png" })
	})
--]]
}
function matchScene:init(match)
    --print("matchScene:init" .. match)
end
function matchScene:enter(match)
	print(match)
  	print(match.load)
	matchScene.match = match
	--matchScene.match:load()
end

function matchScene.keyreleased(k, code)
	--[[
    if key == 'enter' then
        Gamestate.switch(game)
    end
	--]]
    if k == 'a' then
      matchScene.match.isTeam1Attacking = not matchScene.match.isTeam1Attacking
      matchScene.match:initPlayerPosition()
    end
    if k == 's' then
      matchScene.match.isTeam2Attacking = not matchScene.match.isTeam2Attacking
      matchScene.match:initPlayerPosition()
    end
    if k == 'p' then
      matchScene.match.paused = not matchScene.match.paused
    end
end


function matchScene.update(dt)
	--matchScene.match:update()
    --Entities.update(dt)
end

function matchScene.draw()
	--matchScene.matchLdraw()
    --Entities.draw()
end



return matchScene