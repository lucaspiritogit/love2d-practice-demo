require("brickSpawner")

Brick = {}

function Brick:new(x, y, width, height, color, hp)
    local brick = {
        x = x,
        y = y,
        width = width,
        height = height,
        color = color,
        hp = hp
    }
    setmetatable(brick, self)
    self.__index = self
    return brick
end

function Brick:collide(ball)
    if CheckCollision(self, ball) then
        self.hp = self.hp - 1
        if self.hp == 0 then
            return true
        else
            ball.speed = ball.speed + 3.5

            local collisionAngle = math.atan((ball.y + ball.height / 2) - (self.y + self.height / 2),
                (ball.x + ball.width / 2) - (self.x + self.width / 2))
            ball.xVel = ball.speed * math.cos(collisionAngle)
            ball.yVel = ball.speed * math.sin(collisionAngle)
        end
    end
    return false
end

function Brick:load()
    Bricks = BrickSpawner:spawnBricks(math.random(2, 5), math.random(2, 4), 200, 30)
end

function Brick:update(dt)
    for i, brick in ipairs(Bricks) do
        if brick:collide(Ball) then
            table.remove(Bricks, i)
            Player.points = Player.points + 1
        end
    end
end

function Brick:drawBrick()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Brick:draw()
    for _, brick in ipairs(Bricks) do
        brick:drawBrick()
    end
end
