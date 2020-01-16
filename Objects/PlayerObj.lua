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
  self.keys.left = {"left", "a"}
  self.keys.right = {"right", "d"}
  self.keys.jump = {"up", "w"}

  self.sprite = PlayerSprite(2, 2)

  self.gunPos = {offsetX = self.w/2, offsetY = self.h/3}
  self.gun = Gun()
end

function PlayerObj:update(world, dt)
  if world:hasItem(objects.player) then
    self:move(self.speed, self.friction, dt) --200, 9
    self:gravity(895, dt) --895
    self:collide(world, dt)
    self.sprite:update(dt)
    self.gun:update(dt)
  end
end

function PlayerObj:move(speed, friction, dt)
  local left = love.keyboard.isDown(self.keys.left[1]) or love.keyboard.isDown(self.keys.left[2])
  local right = love.keyboard.isDown(self.keys.right[1]) or love.keyboard.isDown(self.keys.right[2])
  if left then
    self.xv = self.xv - speed * dt
  elseif right then
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
  local jump = (key == self.keys.jump[1] or key == self.keys.jump[2])
  if jump and self.jumpLeft > 0 then
    self.yv = -self.jumpSpeed
    self.jumpLeft = self.jumpLeft - 1
  end
end

function PlayerObj:respawn(x, y)
  self.x = x
  self.y = y
end

function PlayerObj:draw()
  self.sprite:draw()
  self.gun:draw()
  --love.graphics.setColor(hex.rgb("ffffff"))
  --love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
