Particle = Object:extend()

function Particle:new(x, y, w, h, r, g, b, grv, xSpeed, yv)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.color = {r, g, b}

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
  love.graphics.setColor(unpack(self.color))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
