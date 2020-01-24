BasicEnemy = Enemy:extend()

function BasicEnemy:new(x, y, w, h, speed)
  BasicEnemy.super.new(self, x, y, w, h, speed)

  self.guns = {BasicEnemyGun(self, -20, 20), BasicEnemyGun(self, 20, -20)}
end

function BasicEnemy:update(world, dt)
  BasicEnemy.super.update(self, world, dt)
  for i=1,2 do
    self.guns[i]:update(dt)
  end
end

function BasicEnemy:draw()
  for i=1,2 do
    self.guns[i]:draw()
  end
  BasicEnemy.super.draw(self)
end
