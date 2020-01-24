Particle = Object:extend()

function Particle:new(x, y, w, h, color, grv, xSpeed, yv)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.color = color

  self.grv = grv
  self.xSpeed = xSpeed
  self.yv = yv
end

function Particle:update(dt)
  self:gravity(dt)
  self:move(dt)
end

function Particle:gravity(dt)
  self.yv = self.yv + self.grv*dt
  self.y = self.y + self.yv*dt
end

function Particle:move(dt)
  self.x = self.x + self.xSpeed*dt
end

function Particle:draw()
  love.graphics.setColor(hex.rgb(self.color))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
