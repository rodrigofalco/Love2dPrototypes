SoccerPlayer = require "SoccerPlayer"
formations = require "formations"
--[[
Team module.
Here we define the teams data
]]

local patPlayerIcon = love.graphics.newImage("resources/redplayer.png")
local enePlayerIcon = love.graphics.newImage("resources/blueplayer.png")


local teams = {
	patagonian = {
		name = "Patagonian Technologies",
		shortName = "pat",
		formation = formations["4-4-2a"],
		players = {
			SoccerPlayer.new({ number = 1, name = 'Bruno', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 2, name = 'Edu', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 6, name = 'Agustin', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 3, name = 'Manu', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 4, name = 'Coco', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 5, name = 'Dani', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 8, name = 'Euge', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 9, name = 'Ricardo', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 10, name = 'Juan', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 14, name = 'Ernesto', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 11, name = 'Fede', image = patPlayerIcon }),
			SoccerPlayer.new({ number = 7, name = 'Sergio', image = patPlayerIcon })	
		}
	},
	enemies = {
		name = "Enemigos",
		shortName = "ene",
		formation = formations["4-3-3a"],
		players = {
			SoccerPlayer.new({ number = 1, name = 'Gitano', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 3, name = 'GGts', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 6, name = 'Eclipse', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 2, name = 'Windows', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 4, name = 'Apple', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 7, name = 'Faveit', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 8, name = 'Smith', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 5, name = 'Robobobo', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 10, name = 'Rebut', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 9, name = 'STR', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 11, name = 'PFT', image = enePlayerIcon }),
			SoccerPlayer.new({ number = 12, name = 'Messi', image = enePlayerIcon })	
		}
	}
}

return teams