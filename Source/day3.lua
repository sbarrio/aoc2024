function day3_1(doneCallback)
    --local path = 'assets/data/day3_1_example.txt'
    local path = 'assets/data/day3.txt'
    local data = readFile(path)
    local res = 0

    for _, line in ipairs(data) do
        for m in string.gmatch(line, "mul%(%d%d?%d?,%d%d?%d?%)") do
            local a, b = m:match("(%d+),(%d+)")
            res += a * b;
        end
    end

    print(res)

    Message.show({"Result is: " .. res}, "Day 3-1", doneCallback)
end

function day3_2(doneCallback)
    --local path = 'assets/data/day3_2_example.txt'
    local path = 'assets/data/day3.txt'
    local data = readFile(path)
    local enabled = true
    local res = 0

    for _, line in ipairs(data) do
        -- Using | for optional string matchers didn't work, although it supposedly should, so I ended up using daExile's regexp: 
        -- https://www.reddit.com/r/adventofcode/comments/1h5frsp/comment/m05ujx1/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        for op, args in string.gmatch(line, "([md][ulon't]+)(%([%d,]*%))") do
            if op == "do" then
                enabled = true
            elseif op == "don't" then
                enabled = false
            elseif op == "mul" and args:match("%(%d%d?%d?%,%d%d?%d?%)") then
                if enabled then
                    local a, b = args:match("(%d+),(%d+)")
                    res += a * b;
                end
            end
        end
    end

    print(res)

    Message.show({"Result is: " .. res}, "Day 3-2", doneCallback)
end
