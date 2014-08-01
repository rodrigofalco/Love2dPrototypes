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

  player:moveTo(dt, tacticalPosition, true)

end

function DefensiveState.__tostring()
	return "DefensiveState"
end

return DefensiveState