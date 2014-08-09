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
			SoccerPlayer.new({index = 1, number = 1, name = 'Bruno', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 3,  number = 2, name = 'Edu', image = patPlayerIcon, stats = { maxSpeed = 8.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 4,  number = 6, name = 'Agustin', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 2,  number = 3, name = 'Manu', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 5,  number = 4, name = 'Coco', image = patPlayerIcon, stats = { maxSpeed = 9.0, acceleration = 9.0 } }),
			SoccerPlayer.new({index = 7,  number = 5, name = 'Dani', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 10, number = 9, name = 'Ricardo', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 6,  number = 8, name = 'Euge', image = patPlayerIcon, stats = { maxSpeed = 7.0, acceleration = 8.0 } }),
			SoccerPlayer.new({index = 8,  number = 10, name = 'Juan', image = patPlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 11,  number = 11, name = 'Fede', image = patPlayerIcon, stats = { maxSpeed = 7.0, acceleration = 7.0 } }),
			SoccerPlayer.new({index = 9,  number = 7, name = 'Sergio', image = patPlayerIcon, stats = { maxSpeed = 8.0, acceleration = 8.0 } })
		}
	},
	enemies = {
		name = "Enemigos",
		shortName = "ene",
		formation = formations["4-3-3a"],
		players = {
			SoccerPlayer.new({index = 1, number = 1, name = 'Free1', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 2, number = 3, name = 'Alvaro', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 3, number = 6, name = 'Free2', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 4, number = 2, name = 'Free3', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 5, number = 4, name = 'Ernesto', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 6, number = 7, name = 'Debi', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 7, number = 8, name = 'Iña', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 8, number = 5, name = 'Coco2', image = enePlayerIcon, stats = { maxSpeed = 9.0, acceleration = 9.0 } }),
			SoccerPlayer.new({index = 9, number = 10, name = 'Shuje', image = enePlayerIcon, stats = { maxSpeed = 7.0, acceleration = 6.0 } }),
			SoccerPlayer.new({index = 10, number = 9, name = 'Andres', image = enePlayerIcon, stats = { maxSpeed = 6.0, acceleration = 7.0 } }),
			SoccerPlayer.new({index = 11, number = 11, name = 'Pablo', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } }),
			SoccerPlayer.new({index = 12, number = 12, name = 'Messi', image = enePlayerIcon, stats = { maxSpeed = 5.0, acceleration = 5.0 } })	
		}
	}
}

return teams