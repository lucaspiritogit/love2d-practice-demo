Player = {}

function Player:load()
  self.width = 100
  self.height = 20
  self.speed = 500
  self.y = love.graphics.getHeight() - 100
  self.x = (love.graphics.getWidth() / 2) - (self.width / 2)
  self.points = 0
  self.health = 3
  self.image = ""
end

local function boundPlayerToWindow(self)
  if self.x < 0 then
    self.x = 0
  elseif self.x + self.width > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() - self.width
  end
end

function Player:update(dt)
  boundPlayerToWindow(self)
  if love.keyboard.isDown("left") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed * dt
  end
end

function Player:draw()
  love.graphics.print(self.points, love.graphics.getHeight() / 2, love.graphics.getWidth() / 2, 0, nil)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end