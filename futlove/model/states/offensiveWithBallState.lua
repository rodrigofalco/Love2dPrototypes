--[[
This is the state a player has the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local OffensiveWithBallState = {}

function OffensiveWithBallState.updatePlayerState(dt, player)
	local ball = player.match.ball
  ball.body:setPosition(player.body:getPosition())

end

function OffensiveWithBallState.__tostring()
	return "OffensiveWithBallState"
end

return OffensiveWithBallState