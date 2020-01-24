BasicEnemyGun = Entity:extend()

function BasicEnemyGun:new(obj, offsetX, recoil)
  self.offsetX = offsetX
  self.obj = obj
  self.x = self.obj.x + self.obj.w/2 + self.offsetX
  self.y = self.obj.y + self.obj.h/2

  self.tweener = Timer.new()
  self.recoil = recoil
  self.originalPos = { x = self.obj.x + self.obj.w/2 + self.offsetX, y = self.obj.y + self.obj.h/2}
  self.recoilPos = {x = self.obj.x + self.obj.w/2 + self.recoil, y = self.obj.y + self.obj.h/2 }
end

function BasicEnemyGun:update(dt)
  self.x = self.obj.x + self.obj.w/2 + self.offsetX
  self.y = self.obj.y + self.obj.h/2
  self.originalPos = { x = self.obj.x + self.obj.w/2 + self.offsetX, y = self.obj.y + self.obj.h/2}
  self.recoilPos = {x = self.obj.x + self.obj.w/2 + self.recoil, y = self.obj.y + self.obj.h/2 }
  self.tweener:update(dt)
end

function BasicEnemyGun:inning(targetPos)
  self.tweener:tween(0.1, self, {x = targetPos.x, y = targetPos.y}, "out-quad", function() self:outing() end)
end

function BasicEnemyGun:outing()
  self.tweener:tween(0.1, self, {x = self.originalPos.x, y = self.originalPos.y}, "out-quad")
end

function BasicEnemyGun:shoot()
  self:inning(self.recoilPos)
  local bulletSpeed = 0
  if self.originalPos.x < self.recoilPos.x then
    bulletSpeed = -300
  else
    bulletSpeed = 300
  end
  table.insert(objects.bullets, Bullet(self.x, self.y, 0, bulletSpeed, 50, "enemy", "machineGun"))
end


function BasicEnemyGun:draw()
  love.graphics.setColor(hex.rgb("ffffff"))
  love.graphics.draw(images.spriteSheet, images.enemy.basicGun, self.x, self.y, 0, 1, 1, 16, 16)
end
