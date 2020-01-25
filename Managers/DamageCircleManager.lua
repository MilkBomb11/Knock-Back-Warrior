local dcm = {}

function dcm.update(dt)
  for i,damageCircle in ipairs(objects.damageCircles) do
    damageCircle:detectDamages()
    if damageCircle.die then
      table.remove(objects.damageCircles, i)
    end
  end
end

function dcm.draw()
  for i,damageCircle in ipairs(objects.damageCircles) do
    damageCircle:draw()
  end
end

return dcm
