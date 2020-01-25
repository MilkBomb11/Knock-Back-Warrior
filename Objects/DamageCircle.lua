DamageCircle = Object:extend()

function DamageCircle:new(x, y, r, gunType)
  self.x = x
  self.y = y
  self.r = r
  self.gunType = gunType

  self.die = false
end

local function CircleRectCollisionDetection(circleX,circleY,circleR, rectX,rectY,rectW,rectH)
  local modifiedRect = {
    x = rectX - circleR,
    y = rectY - circleR,
    w = rectW + circleR*2,
    h = rectH + circleR*2
  }
  return CheckCollision(circleX,circleY,1,1, modifiedRect.x,modifiedRect.y,modifiedRect.w,modifiedRect.h)
end

function DamageCircle:detectDamages()
  for i,enemy in ipairs(objects.enemies) do
    if CircleRectCollisionDetection(self.x,self.y,self.r, enemy.x,enemy.y,enemy.w,enemy.h)  then
      enemy.healthBar.health = enemy.healthBar.health - guns_proto[self.gunType].gun.damage
    end
  end
  local player = objects.player
  if CircleRectCollisionDetection(self.x,self.y,self.r, player.x,player.y,player.w,player.h)  then
    player.healthBar.health = player.healthBar.health - guns_proto.enemy[self.gunType].damage
  end
  self.die = true
end

function DamageCircle:draw()
  love.graphics.setColor(hex.rgb("ff0000"))
  love.graphics.circle("line", self.x, self.y, self.r)
end
