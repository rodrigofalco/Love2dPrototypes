--[[
This is the state a player has when his team is defending, and there are no special conditions.
A special condition may be for example, that this player is the closest to the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local DefensiveState = {}

function DefensiveState.updatePlayerState(dt, player)
	-- defending means moveing towards the ideal defensive position, the one in the formation.defense object
  local tacticalPosition = vector(player.formation.defense.y, player.formation.defense.x)
  if (not player.isMyTeamLocal) then
    tacticalPosition = vector(800 - player.formation.defense.y, 600 - player.formation.defense.x)
  end

   -- This is the distance and direction
  local distanceVector = tacticalPosition - player.pos
  local distanceMts = distanceVector:len()

  -- only for player 11
  if (player.index == 10) then
    --print("Player 10 distance to tactical goal:" .. distanceMts)
  end

  -- this will only have direction
  local normalizedDistanceVector = distanceVector:normalized()

  local vx, vy = player.body:getLinearVelocity()
  local playerSpeed = (vx + vy) * dt
  local acc = player.stats.acceleration * player.match.config.engine.accelarationAdjustment * dt

  if playerSpeed <  ((1 / 10) * player.stats.maxSpeed ) and distanceMts > 30 then
    player.body:applyForce(normalizedDistanceVector.x * acc, normalizedDistanceVector.y * acc)
  end

end

function DefensiveState.__tostring()
	return "DefensiveState"
end

return DefensiveState