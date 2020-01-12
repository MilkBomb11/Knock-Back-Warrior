Platform = Entity:extend()

function Platform:new(x, y, w, h)
  Platform.super.new(self, x, y, w, h)
end

function Platform:draw()
  love.graphics.setColor(hex.rgb("88ff88"))
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
