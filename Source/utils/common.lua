local gfx = playdate.graphics

function readFile(path)
    local file = playdate.file.open(path, playdate.file.kFileRead)

    if not file then
        error("Could not open file: " .. path)
    end

    local data = {}
    local line = ""

    while true do
        line = file:readline()

        if not line then 
            break
        end

        table.insert(data, line)
    end

    file:close()

    return data
end

function clearScreen()
	gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0, 0, 400, 240)
end