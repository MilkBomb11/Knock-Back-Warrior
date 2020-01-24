HealthBar = Object:extend()

function HealthBar:new(obj, health, offsetX, offsetY, w, h)
  self.obj = obj
  self.health = health

  self.offsetX = offsetX
  self.offsetY = offsetY

  self.x = self.obj.x + self.offsetX
  self.y = self.obj.y + self.offsetY
  self.w = w
  self.h = h
end

function HealthBar:update()
  self.x = self.obj.x + self.offsetX
  self.y = self.obj.y + self.offsetY
end

function HealthBar:draw()
  love.graphics.setColor(hex.rgb("ff0000"))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  love.graphics.setColor(hex.rgb("00ff00"))
  love.graphics.rectangle("fill", self.x, self.y, self.health/100*self.w, self.h)
end
