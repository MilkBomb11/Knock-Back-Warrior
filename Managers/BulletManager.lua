local bm = {}

function bm.update(dt)
  for bulletIndex,bullet in ipairs(objects.bullets) do
    bullet:update(dt)

    for platformIndex,platform in ipairs(objects.platforms) do
      if CheckCollision(platform.x,platform.y,platform.w,platform.h, bullet.x-bullet.w/2,bullet.y-bullet.h/2,bullet.w,bullet.h) then
        table.remove(objects.bullets, bulletIndex)
        particleManager.spawnParticles( love.math.random(5, 10) , bullet.x, bullet.y)
      end
    end

  end
end

function bm.draw()
  for i,bullet in ipairs(objects.bullets) do
    bullet:draw()
  end
end

return bm
