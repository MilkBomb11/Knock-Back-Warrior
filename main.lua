--[[
TODO : Create gun : can be aimed with mouse, somewhat like a hand cannon (no trigger)

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


mapManager = require "Managers.MapManager"

function Restart()
  objects = {}
  objects.player = PlayerObj(winW/2, winH/10, 24, 38, 1250, 6, 400)
  if not world:hasItem(objects.player) then
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  else
    world:remove(objects.player)
    world:add(objects.player, objects.player.x, objects.player.y, objects.player.w, objects.player.h)
  end

  objects.platforms = {}
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

  Restart()
end

function love.update(dt)
  objects.player:update(world, dt)
end

function love.mousepressed(x, y, button, isTouch)
  objects.player:shoot()
end

function love.draw()
  mapManager.drawMap(map)
  objects.player:draw()
end

function love.keypressed(key, scancode, isrepeat)
  objects.player:jump(key)
end
