local pm = {}

function pm.update(dt)
  for i,particle in ipairs(objects.particles) do
    particle:update(dt)
    if particle.y > winH then
      table.remove(objects.particles, i)
    end
  end
end

function pm.draw()
  for i,particle in ipairs(objects.particles) do
    particle:draw()
  end
end

function pm.spawnParticles(pAmount, x, y)
  for i=1,pAmount do
    local xSpeed = love.math.random(-200, 200)
    local yv = love.math.random(-100, -300)
    local size = love.math.random(2, 5)
    table.insert(objects.particles, Particle(x, y, size, size, 1, 0, 0, 895, xSpeed, yv))
  end
end


return pm
