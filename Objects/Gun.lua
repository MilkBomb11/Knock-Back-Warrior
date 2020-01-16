Gun = Object:extend()

function Gun:new()
  self.x = 0
  self.y = 0
  self.dir = 0
end

function Gun:update(dt)
  self:followPlayer()
  self:lookAtMouse()
end

function Gun:followPlayer()
  local offsetX = objects.player.gunPos.offsetX
  local offsetY = objects.player.gunPos.offsetY
  self.x = objects.player.x + offsetX
  self.y = objects.player.y + offsetY
end

function Gun:lookAtMouse()
  local height = love.mouse.getY() - self.y
  local base = love.mouse.getX() - self.x
  self.dir = math.atan2(height, base)
end

function Gun:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(images.spriteSheet, images.gun[1], self.x, self.y, self.dir, 2, 2, 12, 16)
  love.graphics.draw(images.spriteSheet, images.gun[2], self.x, self.y, 0, 1.5, 1.5, 16, 16)
end
