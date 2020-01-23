Enemy = Entity:extend()

function Enemy:new(x, y, w, h, speed)
  Enemy.super.new(self, x, y, w, h)
  self.xv = 0
  self.yv = 0
  self.onGround = false
  self.speed = speed
end

function Enemy:update(world, dt)
  if world:hasItem(objects.player) then
    self:move(dt) --200, 9
    self:gravity(895, dt) --895
    self:collide(world, dt)
  end
end

function Enemy:move(dt)
  self.x = self.x + self.speed*dt
end

function Enemy:gravity(grv, dt)
  self.yv = self.yv + grv*dt
end

function Enemy:collide(world, dt)
  self.onGround = false
  local goalX = self.x + self.speed*dt
  local goalY = self.y + self.yv*dt
  local nextX, nextY, cols, len = world:move(self, goalX, goalY)

  for i=1,len do
    local col = cols[i]
    if col.normal.y == 1 or col.normal.y == -1 then
      self.yv = 0
    end
    if col.normal.x == 1 then
      self.speed = math.abs(self.speed)
    elseif col.normal.x == -1 then
      self.speed = -math.abs(self.speed)
    end
    if col.normal.y == -1 then
      self.onGround = true
    end
  end

  self.x = nextX
  self.y = nextY
end

function Enemy:draw()
  love.graphics.setColor(hex.rgb("ffffff"))
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
