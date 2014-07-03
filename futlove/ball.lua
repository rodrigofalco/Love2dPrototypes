local Ball = {}
Ball.__index = Ball -- failed table lookups on the instances should fallback to the class table, to get methods

-- syntax equivalent to "SoccerPlayer.new = function..."
function Ball.new(options)
  local self = setmetatable({}, Ball)
  self.value = init
  self.x = 0
  self.y = 0
  self.scaleX = 1
  self.scaleY = 1
  self.rotation = 0
  self.image = options.image
  return self
end

function Ball:draw()
	-- minus 10 means minus half our image size, in this case, 20px
	love.graphics.draw(self.image, self.x - 10, self.y - 10)
end

function Ball:update()	
end

return Ball