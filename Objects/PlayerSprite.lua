PlayerSprite = Object:extend()

function PlayerSprite:new(sx, sy)
  self.sx = sx
  self.sy = sy
  self.x = 0
  self.y = 0

  self.currentFrame = 1
  self.timeBtwFrame = 0.2
  self.currentTime = 0
  self.walk_startFrame = 1
  self.walk_lastFrame = 2
  self.jumpFrame = 3
end

function PlayerSprite:update(dt)
  self.x = objects.player.x + objects.player.w/2
  self.y = objects.player.y + objects.player.h/2
  self:directionSwitch()
  self:walk(dt)
end

function PlayerSprite:directionSwitch()
  local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
  local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")
  if left then
    self.sx = -math.abs(self.sx)
  elseif right then
    self.sx = math.abs(self.sx)
  end
end

function PlayerSprite:walk(dt)
  local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
  local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")

  if (left or right) and objects.player.onGround then
    if self.currentFrame == self.jumpFrame then
      self.currentFrame = 1
      self.currentTime = 0.1
    end

    if self.currentTime >= self.timeBtwFrame then
      if self.currentFrame >= self.walk_lastFrame then
        self.currentFrame = self.walk_startFrame
      else
        self.currentFrame = self.currentFrame + 1
      end
      self.currentTime = 0
    else
      self.currentTime = self.currentTime + dt
    end
  elseif not objects.player.onGround then
    self.currentFrame = 3
    self.currentTime = 0
  else
    self.currentFrame = 1
    self.currentTime = 0
  end
end

function PlayerSprite:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(images.spriteSheet, images.player[self.currentFrame], self.x, self.y, 0, self.sx, self.sy, 16, 16)
end
