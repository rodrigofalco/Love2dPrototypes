local SoccerPlayer = {} -- the table representing the class, which will double as the metatable for the instances
SoccerPlayer.__index = SoccerPlayer -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function SoccerPlayer.new(options)
  local self = setmetatable({}, SoccerPlayer)
  self.value = init
  self.x = 0
  self.y = 0
  self.scaleX = 1
  self.scaleY = 1
  self.rotation = 0
  self.image = options["image"]
  return self
end

function SoccerPlayer:draw()
	-- minus 10 means minus half our image size, in this case, 20px
	love.graphics.draw(self.image, self.x - 10, self.y - 10)
end

function SoccerPlayer:update()	
end

return SoccerPlayer