--[[
This is the state a player has when his team is attacking, and noone has the ball, and this is the closest to the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local OffensiveClosestToBallState = {}

function OffensiveClosestToBallState.updatePlayerState(dt, player)
  player:moveTo(dt, player.match.ball.pos)
end

function OffensiveClosestToBallState.__tostring()
	return "OffensiveClosestToBallState"
end

return OffensiveClosestToBallState