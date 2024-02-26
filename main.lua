require("player")
require("ball")
require("brick")
_G.love = require("love")

function love.load()
  Player:load()
  Ball:load()
  Brick:load()
end

function love.update(dt)
  Player:update(dt)
  Ball:update(dt)
  Brick:update(dt)
  if Player.health == 0 then
    love.event.quit()
  end
end

function love.draw()
  Player:draw()
  Ball:draw()
  Brick:draw()
  love.graphics.setColor(1, 1, 1)
end

function CheckCollision(a, b)
  if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
    print("collide")
    return true
  end

  return false
end