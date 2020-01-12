Object = require "Libs.classic"
Camera = require "Libs.camera"
Timer = require "Libs.timer"
Bump = require "Libs.bump"
hex = require "Libs.hexamaniac"

world = Bump.newWorld(64)

winW = love.graphics.getWidth()
winH = love.graphics.getHeight()

require "Objects.Entity"
require "Objects.PlayerObj"
require "Objects.Platform"

function Restart()
  objects = {}
  objects.player = PlayerObj(winW/2, winH/2, 32, 32, 1500, 8, 500)
  if not world:hasItem(objects.player) then
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  else
    world:remove(objects.player)
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  end

  objects.platforms = {
    Platform(30, winH - 100, 800, 100),
    Platform(50, 200, 500, 75)
  }

  for i=1,#objects.platforms do
    world:add(objects.platforms[i], objects.platforms[i].x, objects.platforms[i].y, objects.platforms[i].w, objects.platforms[i].h)
  end
end

function love.load()
  Restart()
end

function love.update(dt)
  objects.player:update(world, dt)
end

function love.draw()
  objects.player:draw()
  for i=1,#objects.platforms do
    objects.platforms[i]:draw()
  end
end

function love.keypressed(key, scancode, isrepeat)
  objects.player:jump(key)
end
