PlayerObj = Entity:extend()

function PlayerObj:new(x, y, w, h, speed, friction, jumpSpeed)
  PlayerObj.super.new(self, x, y, w, h)
  self.xv = 0
  self.yv = 0
  self.onGround = false

  self.speed = speed
  self.friction = friction
  self.jumpSpeed = jumpSpeed
  self.initJumpLeft = 2
  self.jumpLeft = self.initJumpLeft

  self.spawnPointX = x
  self.spawnPointY = y

  self.keys = {}
  self.keys.left = "left"
  self.keys.right = "right"
  self.keys.jump = "up"
end

function PlayerObj:update(world, dt)
  if world:hasItem(objects.player) then
    self:move(self.speed, self.friction, dt) --200, 9
    self:gravity(895, dt) --895
    self:collide(world, dt)
  end
end

function PlayerObj:move(speed, friction, dt)
  if love.keyboard.isDown(self.keys.left) then
    self.xv = self.xv - speed * dt
  elseif love.keyboard.isDown(self.keys.right) then
    self.xv = self.xv + speed * dt
  end
  self.xv = self.xv / (1 + friction*dt)
end

function PlayerObj:gravity(grv, dt)
  self.yv = self.yv + grv*dt
end

function PlayerObj:collide(world, dt)
  self.onGround = false
  local goalX = self.x + self.xv*dt
  local goalY = self.y + self.yv*dt
  local nextX, nextY, cols, len = world:move(self, goalX, goalY)

  for i=1,len do
    local col = cols[i]
    if col.normal.y == 1 or col.normal.y == -1 then
      self.yv = 0
    end
    if col.normal.x == 1 or col.normal.x == -1 then
      self.xv = 0
    end
    if col.normal.y == -1 then
      self.onGround = true
      self.jumpLeft = self.initJumpLeft
    end
  end

  self.x = nextX
  self.y = nextY
end

function PlayerObj:jump(key)
  if key == self.keys.jump and self.jumpLeft > 0 then
    self.yv = -self.jumpSpeed
    self.jumpLeft = self.jumpLeft - 1
  end
end


function PlayerObj:respawn(x, y)
  self.x = x
  self.y = y
end

function PlayerObj:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end