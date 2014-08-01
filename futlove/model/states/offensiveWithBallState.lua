--[[
This is the state a player has the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local OffensiveWithBallState = {}

function OffensiveWithBallState.updatePlayerState(dt, player)
	local ball = player.match.ball
  ball.body:setPosition(player.body:getPosition())

  
  if (player.minRivalDistance < 45) then
    -- If enemy close, pass the ball
    --print(player.minRivalDistance)
    -- pass ball to one of the 3 closest players
    table.sort(player.teammatesDistance, function (a, b) return a.distance < b.distance end)
    --for i=1, 11 do
    --  print(player.teammatesDistance[i])
    --end
    math.randomseed(os.time())
    local xx = math.random(2,4)  -- position 1 is myself, the closes at 0 distance
    --print(xx)
    player:passBallTo(dt, player.teammatesDistance[xx].player)
  else
    -- Go to attack position
    local tacticalPosition = vector(player.formation.attack.y, player.formation.attack.x)
    if (not player.isMyTeamLocal) then
      tacticalPosition = vector(800 - player.formation.attack.y, 600 - player.formation.attack.x)
    end
    player:moveTo(dt, tacticalPosition)
  end
end

function OffensiveWithBallState.__tostring()
	return "OffensiveWithBallState"
end

return OffensiveWithBallState