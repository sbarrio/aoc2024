local UP = '^'
local DOWN = 'v'
local RIGHT = '>'
local LEFT = '<'
local OBSTACLE = '#'
local VISITED = 'X'
local DIRECTIONS =  nil
local callback = nil
local finished = false
local map = nil
local gx = nil
local gy = nil

function day6_1(doneCallback)
    -- local path = 'assets/data/day6_example.txt'
    local path = 'assets/data/day6.txt'
    local data = readFile(path)

    gx = 0
    gy = 0
    map = {}

    for i, col in ipairs(data) do
        local row = {}

        for j = 1, #col do
            row[j] = col:sub(j, j)

            if row[j] == '.' then 
                row[j] = ' '
            end

            if row[j] == UP then
                gx = i
                gy = j
            end
        end

        map[i] = row
    end

    DIRECTIONS = { 
        {id = UP, xm = -1, ym = 0},
        {id = RIGHT, xm = 0, ym = 1},
        {id = DOWN, xm = 1, ym = 0},
        {id = LEFT, xm = 0, ym = -1},
    }

    callback = doneCallback
    finished = false
end

function day6_1_update()

    if finished then
        return
    end

    processStep()
    drawMap()
end

function done()
    finished = true
    local res = countVisited()
    Message.show({"Result is: " .. res}, "Day 6-1", callback) 
end

function processStep()
    local turnTimes = 0
    for _, direction in ipairs(DIRECTIONS) do
        local h = #map
        local w = #map[1]
        local nextX = gx + direction.xm
        local nextY = gy + direction.ym

        if isOutOfBounds(nextX, nextY, h, w) then
            done()
            break
        end

        local nextCell = map[nextX][nextY]
        if nextCell ~= OBSTACLE then
            map[gx][gy] = VISITED
            map[nextX][nextY] = direction.id
            gx = nextX
            gy = nextY
            break
        end

        turnTimes += 1
    end

    while(turnTimes > 0) do
        turn90()
        turnTimes -= 1
    end
end

function turn90()
    local first = table.remove(DIRECTIONS, 1)
    table.insert(DIRECTIONS, first)
end

function countVisited()
    local visited = 1
    for i, row in ipairs(map) do
        for j, col in ipairs(row) do
            if map[i][j] == VISITED then
                visited += 1
            end
        end
    end

    return visited
end

function isOutOfBounds(x, y, width, height)
    return x < 1 or x > width or y < 1 or y > height
end

function drawMap()
    local screenW = 200
    local screenH = 400
    local charWidth = 15
    local charHeight = 10
    local fovX = math.floor(screenW / charWidth - 1)
    local fovY = math.floor(screenH / charHeight - 1)

    for i=0, fovX do
        for j=0, fovY do
            local sx = gx - math.floor(fovX / 2) + i
            local sy = gy - math.floor(fovY / 2) + j
            if not isOutOfBounds(sx, sy, #map, #map[1]) then
                local c = map[sx][sy]
                drawText(c, j * charHeight, i * charWidth)
            end
        end
    end
end

function day6_2(doneCallback)
    --local path = 'assets/data/day6_example.txt'
    local path = 'assets/data/day6.txt'
    local data = readFile(path)

    local res = 0

    print(res)

    Message.show({"Result is: " .. res}, "Day 6-2", doneCallback)
end