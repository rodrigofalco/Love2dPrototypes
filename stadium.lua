local Stadium = {}
Stadium.__index = Stadium


-- syntax equivalent to "Stadium.new = function..."
function Stadium.new(options)
  local self = setmetatable({}, Stadium)
  self.x = 0
  self.y = 0
  self.scaleX = 1
  self.scaleY = 1
  self.rotation = 0
  self.imageSrc = options.imageSrc
  return self
end

function Stadium:load()
	self.image = love.graphics.newImage(self.imageSrc)
end

function Stadium:draw() 
	love.graphics.draw(self.image, self.x, self.y)
end


function Stadium:update()	
end

return Stadium