local em = {}

function em.reset()
  em.enemySpeedPresets = {-50, 50, -100, 100}
  em.timeBtwSpawn = 2
  em.currentTime = 0
end

function em.spawnEnemy()
  local x = love.math.random(0, winW-36)
  local y = -42
  local speed = em.enemySpeedPresets[love.math.random(1, 4)]
  local enemy = BasicEnemy(x, y, 36, 42, speed)
  table.insert(objects.enemies, enemy)
  world:add(enemy, enemy.x, enemy.y, enemy.w, enemy.h)
end

function em.update(world, dt)
  for i,enemy in ipairs(objects.enemies) do
    enemy:update(world, dt)
    if enemy.y > winH then
      world:remove(enemy)
      table.remove(objects.enemies, i)
    end
    if enemy.healthBar.health <= 0 then
      world:remove(enemy)
      table.remove(objects.enemies, i)
    end
  end

  if em.currentTime >= em.timeBtwSpawn then
    em.spawnEnemy()
    em.currentTime = 0
  else
    em.currentTime = em.currentTime + dt
  end
end

function em.draw()
  for i,enemy in ipairs(objects.enemies) do
    enemy:draw()
  end
end

return em
