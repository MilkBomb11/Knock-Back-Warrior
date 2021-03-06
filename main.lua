--[[
TODO : Add enemy obj physics
       Add enemy sprite

player : 20x16
enemy : 18x21

]]


Object = require "Libs.classic"
Camera = require "Libs.camera"
Timer = require "Libs.timer"
Bump = require "Libs.bump"
hex = require "Libs.hexamaniac"
screen = require "Libs.shack"

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
require "Objects.Enemy.Enemy"
require "Objects.Enemy.EnemySprite"
require "Objects.Enemy.Basic.BasicEnemy"
require "Objects.Enemy.Basic.BasicEnemyGun"
require "Objects.HealthBar"
require "Objects.DamageCircle"

mapManager = require "Managers.MapManager"
bulletManager = require "Managers.BulletManager"
particleManager = require "Managers.ParticleManager"
enemyManager = require "Managers.EnemyManager"
enemyManager.reset()
damageCircleManager = require "Managers.DamageCircleManager"

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
  objects.enemies = {}
  objects.damageCircles = {}
  mapManager.loadMap(map)

  enemyManager.spawnEnemy()
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
  screen:setDimensions(winW, winH)

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
  images.bullet = {player = images.quads[18], enemy = images.quads[22]}
  images.enemy = {images.quads[19], images.quads[20]}
  images.enemy.basicGun = images.quads[21]

  currentGun = "boomer"

  guns_proto = {}
  guns_proto.basic = {}
  guns_proto.basic.gun =  Gun(15, 0.3, 25, 600, 50, 8) --recoil, coolTime, knockBack, bulletSpeed, damage, shakeVal
  guns_proto.basic.particle = {{6, 14}, {-200, 200, 100, 300}} --pAmount, xv, -yv
  guns_proto.basic.radius = 5

  guns_proto.machineGun = {}
  guns_proto.machineGun.gun = Gun(20, 0.05, 30, 800, 30, 5)
  guns_proto.machineGun.particle = {{3, 7}, {-200, 200, 400, 150}}
  guns_proto.machineGun.radius = 1

  guns_proto.boomer = {}
  guns_proto.boomer.gun = Gun(22, 2, 40, 500, 100, 20)
  guns_proto.boomer.particle = {{20, 40}, {-250, 250, 200, 600}}
  guns_proto.boomer.radius = 100

  guns_proto.enemy = {}
  guns_proto.enemy.basic = {}
  guns_proto.enemy.basic.damage = 10
  guns_proto.enemy.machineGun = {}
  guns_proto.enemy.machineGun.damage = 5
  guns_proto.enemy.boomer = {}
  guns_proto.enemy.boomer.damage = 20

  Restart()
end

function love.update(dt)
  objects.player:update(world, dt)
  bulletManager.update(dt)
  particleManager.update(dt)
  screen:update(dt)
  enemyManager.update(world, dt)
  damageCircleManager.update(dt)
end

function love.mousepressed(x, y, button, isTouch)
  objects.player:shoot()
end

function love.draw()
  screen:apply()
  mapManager.drawMap(map)
  enemyManager.draw()
  bulletManager.draw()
  objects.player:draw()
  particleManager.draw()
end

function love.keypressed(key, scancode, isrepeat)
  objects.player:jump(key)
end
