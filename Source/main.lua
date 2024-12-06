-- Core libs
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- UI
import "./UI/message"
import "./UI/choice"

-- Utils
import "./utils/common"

-- Puzzles
import "day1"
import "day2"
import "day3"
import "day6"

local gfx = playdate.graphics

local puzzles = {"1-1", "1-2", "2-1", "2-2", "3-1", "3-2", "4-1", "4-2", "5-1" ,"5-2", "6-1", "6-2"}
local dayUpdate = nil

function init()
    clearScreen();
    Message.show({"Please select a puzzle to run:"}, "AOC 24", showChoiceBox)
end

function showChoiceBox()
    Choice.show("Select a puzzle:", puzzles, 2, choiceSelected)
end

function choiceSelected(choiceIndex)
    local funcName = "day" .. string.gsub(puzzles[choiceIndex], "-", "_")
    if _G[funcName] then
        playdate.resetElapsedTime()
        dayUpdate = _G[funcName .. '_update']
        _G[funcName](puzzleDone) 
    else
        Message.show({"That puzzle has not been solved yet."}, "Warning", showChoiceBox)
    end
end

function puzzleDone()
    dayUpdate = nil
    Message.show({"Ran in: " .. playdate.getElapsedTime() .. " seconds"}, "Info", showChoiceBox)
end

-- Main loop
function playdate.update()
    clearScreen();
    Message.update()
    Choice.update() 

    if dayUpdate then
        dayUpdate()
    end
end

-- Start
init()
