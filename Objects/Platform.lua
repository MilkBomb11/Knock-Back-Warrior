Platform = Entity:extend()

function Platform:new(x, y, w, h)
  Platform.super.new(self, x, y, w, h)
end

function Platform:draw()
  love.graphics.setColor(0.5, 1, 0.5)
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
