--[[

player : 20x16

]]


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
require "Objects.PlayerSprite"
require "Objects.Platform"
require "Objects.Gun"
require "Objects.Bullet"
require "Objects.Particle"


mapManager = require "Managers.MapManager"
bulletManager = require "Managers.BulletManager"
particleManager = require "Managers.ParticleManager"

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Restart()
  objects = {}
  objects.player = PlayerObj(winW/2, winH/10, 24, 38, 1250, 6, 400)
  if not world:hasItem(objects.player) then
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  else
    world:remove(objects.player)
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  end

  objects.bullets = {}
  objects.platforms = {}
  objects.particles = {}
  mapManager.loadMap(map)
end

function GetQuads(spriteSheet, cellSize)
  local width = spriteSheet:getWidth()
  local height = spriteSheet:getHeight()
  local quads = {}
  for i=1,width/cellSize do
    for j=1,height/cellSize do
      local quad = love.graphics.newQuad((i-1)*cellSize, (j-1)*cellSize, cellSize, cellSize, width, height)
      table.insert(quads, quad)
    end
  end
  return quads
end

function love.load()
  love.graphics.setBackgroundColor(hex.rgb("69859f"))

  love.graphics.setDefaultFilter("nearest", "nearest")
  images = {}
  images.spriteSheet = love.graphics.newImage("Images/Sprites.png")
  images.quads = GetQuads(images.spriteSheet, 32)
  images.tiles = {}
  for i=1,12 do
    table.insert(images.tiles, images.quads[i])
  end
  images.player = {}
  for i=13,15 do
    table.insert(images.player, images.quads[i])
  end
  images.gun = {images.quads[16], images.quads[17]}
  images.bullet = images.quads[18]

  Restart()
end

function love.update(dt)
  objects.player:update(world, dt)
  bulletManager.update(dt)
  particleManager.update(dt)
end

function love.mousepressed(x, y, button, isTouch)
  objects.player:shoot()
end

function love.draw()
  mapManager.drawMap(map)
  bulletManager.draw()
  objects.player:draw()
  particleManager.draw()
end

function love.keypressed(key, scancode, isrepeat)
  objects.player:jump(key)
end
