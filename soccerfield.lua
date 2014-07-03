local soccerField = {}

soccerField = {}
soccerField.x = 0
soccerField.y = 0
soccerField.scaleX = 1
soccerField.scaleY = 1
soccerField.rotation = 0
soccerField.size = {}
soccerField.size.width = 300
soccerField.size.height = 300
soccerField.field = nil


function soccerField.load()
	soccerField.field = love.graphics.newImage("resources/soccerField800x600.png")
end

function soccerField.draw()
	love.graphics.draw(soccerField.field, soccerField.x, soccerField.y)
end

function soccerField.update()	
end

return soccerField