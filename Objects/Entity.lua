Entity = Object:extend()

function Entity:new(x, y, width, height)
  self.x = x
  self.y = y
  self.w = width
  self.h = height
end
