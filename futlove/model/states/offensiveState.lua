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
  player:moveTo(dt, tacticalPosition, true)
  
end

function OffensiveState.__tostring()
	return "OffensiveState"
end

return OffensiveState