require("player")
require("ball")
require("brick")

_G.love = require("love")
math.randomseed(os.time())

Game = {
  state = {
    menu = false,
    game = true,
    options = false,
  }
}

function love.load()
  if Game.state.game then
    Player:load()
    Ball:load()
    Brick:load()
  end
end

function love.update(dt)
  if Game.state.game then
    Player:update(dt)
    Ball:update(dt)
    Brick:update(dt)
    if Player.health == 0 then
      love.event.quit()
    end
  end
end

function love.draw()
  if Game.state.game then
    Player:draw()
    Ball:draw()
    Brick:draw()
    love.graphics.setColor(1, 1, 1)
  end

  if Game.state.menu then
    love.graphics.print("Start", love.graphics.getWidth()/2 - 30, love.graphics.getHeight()/2)
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  if Game.state.menu then
      Game.state.menu = false
      Game.state.game = true
      Player:load()
      Ball:load()
      Brick:load()
  end
end

function CheckCollision(a, b)
  if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
    return true
  end
  return false
end
