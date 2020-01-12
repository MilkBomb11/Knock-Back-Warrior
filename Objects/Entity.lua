Entity = Object:extend()

function Entity:new(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
end
