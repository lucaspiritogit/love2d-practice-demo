BrickSpawner = {}

function BrickSpawner:spawnBricks(rows, columns, brickWidth, brickHeight)
    local bricks = {}
    local padding = 30
    local startX = (love.graphics.getWidth() - (columns * brickWidth + (columns - 1) * padding)) / 2
    local startY = 50

    for row = 1, rows do
        for col = 1, columns do
            local x = startX + (col - 1) * (brickWidth + padding)
            local y = startY + (row - 1) * (brickHeight + padding)
            local hp = love.math.random(2, 4)

            local color
            if hp <= 2 then
                color = {0, 1, 0}
            elseif hp == 3 then
                color = {0, 0, 1}
            else
                color = {1, 0, 0}
            end
            table.insert(bricks, Brick:new(x, y, brickWidth, brickHeight, color, hp))
        end
    end

    return bricks
end