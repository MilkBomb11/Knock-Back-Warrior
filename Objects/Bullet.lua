Bullet = Entity:extend()

function Bullet:new(x, y, dir, speed, damage, shooterType, gunType)
  Bullet.super.new(self, x, y, 8, 8)
  self.dir = dir
  self.speed = speed
  self.damage = damage
  self.shooterType = shooterType
  if shooterType == "player" then
    self.color = "ff0000"
  else
    self.color = "0000ff"
  end
  self.image = images.bullet[self.shooterType]
  self.gunType = gunType
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
  love.graphics.draw(images.spriteSheet, self.image, self.x, self.y, 0, 1, 1, 16, 16)
  --love.graphics.rectangle("line", self.x-self.w/2, self.y-self.h/2, self.w, self.h)
end
