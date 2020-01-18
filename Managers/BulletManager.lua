local bm = {}

function bm.update(dt)
  for bulletIndex,bullet in ipairs(objects.bullets) do
    bullet:update(dt)

    for platformIndex,platform in ipairs(objects.platforms) do
      if CheckCollision(platform.x,platform.y,platform.w,platform.h, bullet.x-bullet.w/2,bullet.y-bullet.h/2,bullet.w,bullet.h) then
        table.remove(objects.bullets, bulletIndex)
        local particleDatas = guns_proto[currentGun].particle
        particleManager.spawnParticles( love.math.random(unpack(particleDatas[1])) , bullet.x, bullet.y, unpack(particleDatas[2]))
        screen:shake(guns_proto[currentGun].gun.shakeVal)
      end
    end

    if (bullet.x > winW or bullet.x < -bullet.x) or (bullet.y < -bullet.h or bullet.y > winH) then
      table.remove(objects.bullets, bulletIndex)
    end

  end
end

function bm.draw()
  for i,bullet in ipairs(objects.bullets) do
    bullet:draw()
  end
end

return bm
