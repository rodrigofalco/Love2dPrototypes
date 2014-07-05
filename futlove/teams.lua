SoccerPlayer = require "model.SoccerPlayer"
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
			SoccerPlayer.new({pos = 1, number = 1, name = 'Bruno', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 2,  number = 2, name = 'Edu', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 3,  number = 6, name = 'Agustin', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 4,  number = 3, name = 'Manu', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 5,  number = 4, name = 'Coco', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 6,  number = 5, name = 'Dani', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 7,  number = 8, name = 'Euge', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 8, number = 9, name = 'Ricardo', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 9,  number = 10, name = 'Juan', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 10,  number = 14, name = 'Ernesto', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 11,  number = 11, name = 'Fede', image = patPlayerIcon }),
			SoccerPlayer.new({pos = 12,  number = 7, name = 'Sergio', image = patPlayerIcon })	
		}
	},
	enemies = {
		name = "Enemigos",
		shortName = "ene",
		formation = formations["4-3-3a"],
		players = {
			SoccerPlayer.new({pos = 1, number = 1, name = 'Gitano', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 2, number = 3, name = 'GGts', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 3, number = 6, name = 'Eclipse', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 4, number = 2, name = 'Windows', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 5, number = 4, name = 'Apple', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 6, number = 7, name = 'Faveit', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 7, number = 8, name = 'Smith', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 8, number = 5, name = 'Robobobo', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 9, number = 10, name = 'Rebut', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 10, number = 9, name = 'STR', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 11, number = 11, name = 'PFT', image = enePlayerIcon }),
			SoccerPlayer.new({pos = 12, number = 12, name = 'Messi', image = enePlayerIcon })	
		}
	}
}

return teams