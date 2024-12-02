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

local gfx = playdate.graphics

local puzzles = {"1-1", "1-2", "2-1", "2-2", "3-1", "3-2"}

function init()
    clearScreen(gfx.kColorBlack);
    Message.show({"Please select a puzzle to run:"}, "AOC 24", showChoiceBox)
end

function showChoiceBox()
    Choice.show("Select a puzzle", puzzles, 2, choiceSelected)
end

function choiceSelected(choiceIndex)
    local funcName = "day" .. string.gsub(puzzles[choiceIndex], "-", "_")
    if _G[funcName] then
        playdate.resetElapsedTime()
        _G[funcName](puzzleDone) 
    else
        Message.show({"That puzzle does not exist yet"}, "Warning", showChoiceBox)
    end
end

function puzzleDone()
    Message.show({"Ran in: " .. playdate.getElapsedTime() .. " seconds"}, "Info", showChoiceBox)
end

function clearScreen(color) -- use gfx.kColorBlack or gfx.kColorWhite
	gfx.setColor(color)
    gfx.fillRect(0, 0, 400, 240)
end

-- Main loop
function playdate.update()
    clearScreen(gfx.kColorBlack);
    gfx.sprite.update()
    Message.update()
    Choice.update() 
end

-- Start
init()
