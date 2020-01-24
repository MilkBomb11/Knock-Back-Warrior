BasicEnemyGun = Entity:extend()

function BasicEnemyGun:new(obj, offsetX, recoil)
  self.offsetX = offsetX
  self.obj = obj
  self.x = self.obj.x + self.obj.w/2 + self.offsetX
  self.y = self.obj.y + self.obj.h/2

  self.recoil = recoil
  self.originalPos = { x = self.obj.x + self.obj.w/2 + self.offsetX, y = self.obj.y + self.obj.h/2}
  self.recoilPos = {x = self.obj.x + self.obj.w/2 + self.recoil, y = self.obj.y + self.obj.h/2 }
end

function BasicEnemyGun:update(dt)
  self.x = self.obj.x + self.obj.w/2 + self.offsetX
  self.y = self.obj.y + self.obj.h/2
end

function BasicEnemyGun:draw()
  love.graphics.setColor(hex.rgb("ffffff"))
  love.graphics.draw(images.spriteSheet, images.enemy.basicGun, self.x, self.y, 0, 1, 1, 16, 16)
end
