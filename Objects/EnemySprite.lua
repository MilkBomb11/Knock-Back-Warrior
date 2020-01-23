EnemySprite = Object:extend()

function EnemySprite:new(obj)
  self.currentTime = 0
  self.timeBtwFrmae = 0.2
  self.currentFrame = 1
  self.totalFrames = 2

  self.obj = obj
  self.x = self.obj.x + self.obj.w/2
  self.y = self.obj.y + self.obj.h/2
end

function EnemySprite:update(dt)
  self.x = self.obj.x + self.obj.w/2
  self.y = self.obj.y + self.obj.h/2

  if not self.obj.onGround then
    self.currentFrame = 1
  else
    if self.currentTime >= self.timeBtwFrmae then
      if self.currentFrame >= self.totalFrames then
        self.currentFrame = 1
      else
        self.currentFrame = self.currentFrame + 1
      end
      self.currentTime = 0
    else
      self.currentTime = self.currentTime + dt
    end
  end
end

function EnemySprite:draw()
  love.graphics.setColor(hex.rgb("ffffff"))
  love.graphics.draw(images.spriteSheet, images.enemy[self.currentFrame], self.x, self.y, 0, 2, 2, 16, 16)
end
