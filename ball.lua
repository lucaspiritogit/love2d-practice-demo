Ball = {}


function Ball:load()
  BALL_DEFAULT_STARTING_POSITION_Y = love.graphics.getHeight() / 2
  BALL_DEFAULT_STARTING_POSITION_X = love.graphics.getWidth() / 2
  self.y = BALL_DEFAULT_STARTING_POSITION_Y
  self.x = BALL_DEFAULT_STARTING_POSITION_X
  self.width = 10
  self.height = 10
  self.speed = 400
  self.xVel = 0
  self.yVel = self.speed
  self.hasFallen = false
  self.image = ""
end

local function boundBallBetweenLimits(self)
  if self.y < 0 then
    -- if it hits the top, bounces
    print("top")
    self.y = 0
    self.yVel = -self.yVel
  elseif self.x < 0 then
    -- if it hits the left side of the window, bounces
    print("left")
    self.x = 0
    self.xVel = -self.xVel
  elseif self.x + self.width > love.graphics.getWidth() then
    -- if it hit the right side of the window, bounces
    print("right")
    self.x = love.graphics.getWidth() - self.width
    self.xVel = -self.xVel
  elseif self.y + self.height > love.graphics.getHeight() then
    -- out of bounds, goes to the bottom and it is considered a loose ball
    if not self.hasFallen then
      self.hasFallen = true
      self.y = BALL_DEFAULT_STARTING_POSITION_Y
      self.x = BALL_DEFAULT_STARTING_POSITION_X
      self.xVel = 0
      self.yVel = self.speed
      Player.health = Player.health - 1
      Player.x = PLAYER_DEFAULT_STARTING_POSITION_X
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
    print(self.yVel)
  end

  boundBallBetweenLimits(self)
end

function Ball:update(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
  self:collide()
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
