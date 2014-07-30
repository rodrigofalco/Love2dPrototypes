--[[
This is the state a player has when his team is attacking, and there are no special conditions.
A special condition may be for example, that this player is the one with the ball.

Should be stateless/singleton, so only one instance is used.
--]]
local OffensiveState = {}

function OffensiveState.updatePlayerState(dt, player)
	-- attacking means moveing towards the ideal attacking position, the one in the formation.attack object
  local tacticalPosition = vector(player.formation.attack.y, player.formation.attack.x)
  if (not player.isMyTeamLocal) then
    tacticalPosition = vector(800 - player.formation.attack.y, 600 - player.formation.attack.x)
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

function OffensiveState.__tostring()
	return "OffensiveState"
end

return OffensiveState