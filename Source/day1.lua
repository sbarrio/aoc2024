function day1_1(doneCallback)
    --local path = 'assets/data/day1_example.txt'
    local path = 'assets/data/day1.txt'
    local data = readFile(path)

    local a = {}
    local b = {}

    for i, line in ipairs(data) do
        local a1, b1 = string.match(line, "(%d+)%s+(%d+)")
        table.insert(a, tonumber(a1))
        table.insert(b, tonumber(b1))
    end

    table.sort(a)
    table.sort(b)

    local res = 0
    for i, a in ipairs(a) do
        res += math.abs(a - b[i])
    end

    Message.show({"Result is: " .. res}, "Day 1-1", doneCallback);
end

function day1_2(doneCallback)
    -- local path = 'assets/data/day1_example.txt'
    local path = 'assets/data/day1.txt'
    local data = readFile(path)

    local a = {}
    local b = {}

    for i, line in ipairs(data) do
        local a1, b1 = string.match(line, "(%d+)%s+(%d+)")
        table.insert(a, tonumber(a1))
        table.insert(b, tonumber(b1))
    end

    local res = 0;
    for i, a in ipairs(a) do
        local count = countOcurrences(a, b)
        print(a .. " " .. b[i] .. " " .. count .. " " .. a * count)
        res += a * count
    end

    Message.show({"Result is: " .. res}, "Day 1-2", doneCallback);
end

function countOcurrences(num, table)
    local count = 0

    for _, n in ipairs(table) do
        if n == num then
            count += 1
        end
    end

    return count
end