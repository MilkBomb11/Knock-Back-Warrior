local mm = {}

function mm.loadMap(map)
  local mapObjects = map.layers[2].objects
  for i=1,#mapObjects do
    local obj = mapObjects[i]
    table.insert(objects.platforms, Platform(obj.x, obj.y, obj.width, obj.height))
  end
  for i=1,#objects.platforms do
    if not world:hasItem(objects.platforms[i]) then
      world:add(objects.platforms[i], objects.platforms[i].x, objects.platforms[i].y, objects.platforms[i].w, objects.platforms[i].h)
    else
      world:remove(objects.platforms[i])
      world:add(objects.platforms[i], objects.platforms[i].x, objects.platforms[i].y, objects.platforms[i].w, objects.platforms[i].h)
    end
  end
end

function mm.drawMap(map)
  local data = map.layers[1].data
  for y=1,#data do
    for x=1,#data[y] do
      if data[y][x] == 1 then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(testTile, (x-1)*32, (y-1)*32, 0, 1, 1)
      end
    end
  end
end

return mm
