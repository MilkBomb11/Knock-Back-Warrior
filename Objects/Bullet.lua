Bullet = Entity:extend()

function Bullet:new(x, y, dir, speed, damage)
  Bullet.super.new(self, x, y, 8, 8)
  self.dir = dir
  self.speed = speed
  self.damage = damage
end

function Bullet:update(dt)
  self:move(dt)
end

function Bullet:move(dt)
  local dx = math.cos(self.dir) * self.speed
  local dy = math.sin(self.dir) * self.speed
  self.x = self.x + dx*dt
  self.y = self.y + dy*dt
end

function Bullet:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(images.spriteSheet, images.bullet, self.x, self.y, 0, 1, 1, 16, 16)
  --love.graphics.rectangle("line", self.x-self.w/2, self.y-self.h/2, self.w, self.h)
end
