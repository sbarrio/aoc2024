function day2_1(doneCallback)
    --local path = 'assets/data/day2_example.txt'
    local path = 'assets/data/day2.txt'

    local data = readFile(path)
    local reports = {}

    for i, line in ipairs(data) do
        local levels = {}
        for level in string.gmatch(line, "%S+") do
            table.insert(levels, tonumber(level))
        end

        table.insert(reports, levels)
    end

    local res = 0
    for i, levels in ipairs(reports) do
        if areLevelsSafe(levels) then
            res += 1
        end
    end

    Message.show({"Result is: " .. res}, "Day 2-1", doneCallback)
end

function day2_2(doneCallback)
    --local path = 'assets/data/day2_edge_case.txt'
    --local path = 'assets/data/day2_example.txt'
    local path = 'assets/data/day2.txt'

    local data = readFile(path)
    local reports = {}

    for i, line in ipairs(data) do
        local levels = {}
        for level in string.gmatch(line, "%S+") do
            table.insert(levels, tonumber(level))
        end

        table.insert(reports, levels)
    end

    local res = 0
    for i, levels in ipairs(reports) do
        if areLevelsSafe(levels) then
            res += 1
        else
            for j=1, #levels do
                local newLevels = copyTable(levels)
                table.remove(newLevels, j)

                if areLevelsSafe(newLevels) then
                    res += 1
                    break
                end
            end
            
        end
    end

    Message.show({"Result is: " .. res}, "Day 2-2", doneCallback)
end

function areLevelsSafe(levels)
    -- The levels are either all increasing or all decreasing.
    -- Any two adjacent levels differ by at least one and at most three.
    local isIncreasing = nil

    for i = 1, #levels - 1 do
        local diff = math.abs(levels[i + 1] - levels[i])

        if diff < 1 or diff > 3 then
            return false
        end

        if isIncreasing == nil then
            isIncreasing = levels[i] < levels[i + 1]
        elseif isIncreasing and levels[i] > levels[i + 1] then
            return false
        elseif not isIncreasing and levels[i] < levels[i + 1] then
            return false
        end
    end

    return true
end

function copyTable(original)
    local copy = {}

    for k, v in pairs(original) do
        copy[k] = v
    end

    return copy
end
