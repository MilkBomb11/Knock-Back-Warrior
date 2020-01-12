Object = require "Libs.classic"
Camera = require "Libs.camera"
Timer = require "Libs.timer"
Bump = require "Libs.bump"
hex = require "Libs.hexamaniac"

world = Bump.newWorld(64)

winW = love.graphics.getWidth()
winH = love.graphics.getHeight()
map = require "Tilemap.Map"

require "Objects.Entity"
require "Objects.PlayerObj"
require "Objects.Platform"

mapManager = require "Managers.MapManager"

function Restart()
  objects = {}
  objects.player = PlayerObj(winW/2, winH/10, 32, 32, 1000, 4, 400)
  if not world:hasItem(objects.player) then
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  else
    world:remove(objects.player)
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  end

  objects.platforms = {}
  mapManager.loadMap(map)
end

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  testTile = love.graphics.newImage("Images/Tile.png")

  Restart()
end

function love.update(dt)
  objects.player:update(world, dt)
end

function love.draw()
  mapManager.drawMap(map)
  objects.player:draw()
  for i=1,#objects.platforms do
    objects.platforms[i]:draw()
  end
end

function love.keypressed(key, scancode, isrepeat)
  objects.player:jump(key)
end
