Gun = Object:extend()

function Gun:new(recoil)
  self.x = 0
  self.y = 0
  self.dir = 0

  self.recoil = recoil
  self.tweener = Timer.new()
  self.fixedPos = {}
end

function Gun:update(dt)
  self.fixedPos.x = objects.player.x + objects.player.gunPos.offsetX
  self.fixedPos.y = objects.player.y + objects.player.gunPos.offsetY

  self:followPlayer()
  self:lookAtMouse()
  self.tweener:update(dt)
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

function Gun:inning(targetPos)
  self.tweener:tween(0.1, self, {x = targetPos.x, y = targetPos.y}, "out-quad", function() self:outing() end)
end

function Gun:outing()
  self.tweener:tween(0.1, self, {x = self.fixedPos.x, y = self.fixedPos.y}, "out-quad")
end

function Gun:shoot()
  local dx = -(math.cos(self.dir) * self.recoil)
  local dy = -(math.sin(self.dir) * self.recoil)
  local dPos = {x = self.fixedPos.x + dx, y = self.fixedPos.y + dy}
  self:inning(dPos)
end

function Gun:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(images.spriteSheet, images.gun[1], self.x, self.y, self.dir, 2, 2, 12, 16)
  love.graphics.draw(images.spriteSheet, images.gun[2], self.fixedPos.x, self.fixedPos.y, 0, 1.5, 1.5, 16, 16)
end
