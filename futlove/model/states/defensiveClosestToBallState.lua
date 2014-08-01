--[[
This is the state a player has when his team is defending, and the player is the closest to the ball.
--]]
local DefensiveClosestToBallState = {}

function DefensiveClosestToBallState.updatePlayerState(dt, player)
  player:moveTo(dt, player.match.ball.pos)
end

function DefensiveClosestToBallState.__tostring()
	return "DefensiveClosestToBallState"
end

return DefensiveClosestToBallState