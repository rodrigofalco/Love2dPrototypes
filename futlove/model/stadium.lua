local Stadium = {}
Stadium.__index = Stadium

-- syntax equivalent to "Stadium.new = function..."
function Stadium.new(options)
  local self = setmetatable({}, Stadium)
  self.x = 0
  self.y = 0
  self.width = 800
  self.height = 600
  self.playableArea = options.playableArea or { x = 64, y = 64, width = 606, height = 410 }
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

  -- debug
  if SoccerFieldDebugInfoEnabled then
    r, g, b, a = love.graphics.getColor()
    local limit = self.playableArea
    --love.graphics.rectangle("line", limit.x, limit.y, limit.x + limit.width, limit.y + limit.height)
    -- Draw corner area
    love.graphics.setColor(232, 0, 0, 255)
    love.graphics.rectangle("line", 0, 0, limit.x, self.height)
    love.graphics.rectangle("line", limit.x, 0, self.width, self.height)
    
    -- Draw sidelines area
    love.graphics.setColor(0, 0, 232, 255)
    love.graphics.rectangle("line", limit.x, 0, limit.x + limit.width, limit.y)
    love.graphics.rectangle("line", limit.x, limit.y * 2 + limit.height, limit.x + limit.width, self.height)
    
    love.graphics.setColor(r, g, b, a)
  end

  
end

function Stadium:update(dt)	
end

return Stadium