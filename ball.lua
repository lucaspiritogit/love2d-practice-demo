Ball = {}

function Ball:load()
  self.y = love.graphics.getHeight() / 2
  self.x = love.graphics.getWidth() / 2
  self.width = 10
  self.height = 10
  self.speed = 500
  self.xVel = 0
  self.yVel = self.speed
  self.hasFallen = false
  self.image = ""
end

local function loseBall(self)
  if self.y < 0 then
    self.y = 0
    self.yVel = -self.yVel
  elseif self.x < 0 then
    self.x = 0
    self.xVel = -self.xVel
  elseif self.x + self.width > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() - self.width
    self.xVel = -self.xVel
  elseif self.y + self.height > love.graphics.getHeight() then
    if not self.hasFallen then
      self.hasFallen = true
      self.y = love.graphics.getHeight() / 2
      self.x = love.graphics.getWidth() / 2
      self.xVel = 0
      self.yVel = self.speed
      Player.health = Player.health - 1
    end
  else
    self.hasFallen = false
  end
end


function Ball:collide()
  if CheckCollision(self, Player) then
    local ballCenterX = self.x + self.width / 2
    local playerCenterX = Player.x + Player.width / 2
    local collisionAngle = (ballCenterX - playerCenterX) / (Player.width / 2)

    self.xVel = self.speed * collisionAngle
    self.yVel = -self.speed
  end

  loseBall(self)
end

function Ball:update(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
  self:collide()
end

function Ball:draw()
  love.graphics.circle("fill", self.x, self.y, self.width, self.height)
end
