--[[
This is the state a player has when his team is attacking, and noone has the ball, and this is the closest to the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local OffensiveClosestToBallState = {}

function OffensiveClosestToBallState.updatePlayerState(dt, player)
	-- This is the distance and direction
  local distanceVector = player.match.ball.pos - player.pos
  local distanceMts = distanceVector:len()
  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = player.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = player.stats.acceleration * player.match.config.engine.accelarationAdjustment * dt

  --print(distanceMts)
  if (distanceMts > 20) then
    -- go to the ball
    if playerSpeed <  ((1 / 10) * player.stats.maxSpeed ) then
      player.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
    end
  else 
    -- ball is in reach
    --player.match.ball.body:setLinearVelocity(0, 0)
    --player.body:setLinearVelocity(0, 0)
  end
end

function OffensiveClosestToBallState.__tostring()
	return "OffensiveClosestToBallState"
end

return OffensiveClosestToBallState