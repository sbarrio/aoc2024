local gfx = playdate.graphics
local snd = playdate.sound
Message = {}

-- Constants
MAX_LINE = 40
FONT_SIZE = 10
PRINT_DELAY = 1
X = 15
Y = 191
X2 = X + 370
Y2 = Y + 47
ORIG_X = 30
ORIG_Y = 207
TITLE_X = ORIG_X - 8
TITLE_Y = ORIG_Y - 34
TITLE_WIDTH = 120
TITLE_HEIGHT = 19
PROMPT_X = ORIG_X + 330
PROMPT_Y = ORIG_Y + 8
PROMPT_DELAY = 8

-- Local functions
local function clearTextBox()
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(X, Y, X2 - X, Y2 - Y)
end

local function drawTextBox()
    clearTextBox()

	gfx.setColor(gfx.kColorWhite)
	gfx.drawLine(X, Y, X2, Y)
	gfx.drawLine(X, Y, X, Y2)
	gfx.drawLine(X2, Y, X2, Y2)
	gfx.drawLine(X, Y2, X2, Y2)
end

local function drawText(text) 
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText(text, ORIG_X, ORIG_Y)
end

local function drawTitle(text)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(X, Y-TITLE_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText(text, TITLE_X, TITLE_Y)
end

local function drawButtonPrompt()
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText("Ⓐ", PROMPT_X, PROMPT_Y)
end

-- Globals
local enabled 
local readyForNextLine
local showButtonPrompt
local showButtonPromptDelay
local aButtonIsDown 
local textLines
local messageTitle
local currentLineIndex
local currentCharIndex
local currentLine
local endCallback

-- Main functions
function Message.reset()
    enabled = false
    readyForNextLine = false
    showButtonPrompt = false
    showButtonPromptDelay = PROMPT_DELAY
    aButtonIsDown = false
    textLines = {}
    messageTitle = nil
    currentLineIndex = 1
    currentCharIndex = 1
    currentLine = ""
    printDelay = PRINT_DELAY
    endCallback = nil
end

function Message.show(lines, title, callback)
    Message.reset()
    textLines = lines
    if (title) then
        messageTitle = title
    end
    if (callback) then
        endCallback = callback
    end
    enabled = true
end

function Message.update()
    -- Update logic runs only when enabled
    if (not enabled) then
        return
    end

    -- Check for input
    if playdate.buttonJustPressed('a') or playdate.buttonIsPressed('a') then
        printDelay = 0
    end

    if playdate.buttonJustReleased('a') and readyForNextLine then
        -- Avoids dismissing the message if the a button was already down
        -- Forcing the player to tap it again
        if (aButtonIsDown) then
            aButtonIsDown = false            
        else
            currentCharIndex = 1
            currentLineIndex += 1
            currentLine = ""
            aButtonIsDown = false
            showButtonPrompt = false
            showButtonPromptDelay = PROMPT_DELAY
            readyForNextLine = false
            printDelay = PRINT_DELAY

            -- Done printing lines?
            if (currentLineIndex > #textLines) then
                enabled = false
                clearTextBox()
                if (endCallback) then
                    endCallback()
                end
                return
            end
        end
    end

    -- Printing chars
    if (not readyForNextLine) then
        if (currentCharIndex <= #textLines[currentLineIndex]) then
            if (printDelay <= 0) then
                local charToWrite =  string.sub(textLines[currentLineIndex], currentCharIndex, currentCharIndex)
                currentLine = currentLine .. charToWrite
                currentCharIndex += 1
                printDelay = PRINT_DELAY
            else
                printDelay -= 1
            end
        else
            readyForNextLine = true
            showButtonPrompt = true
            showButtonPromptDelay = PROMPT_DELAY
            -- used to avoid dismissing the message box too fast if a button is kept pressed
            aButtonIsDown = playdate.buttonIsPressed('a')
        end
    end

    -- Render it all
    drawTextBox()
    drawText(currentLine)
    if (messageTitle) then
        drawTitle(messageTitle)
    end

    if (showButtonPrompt) then
        -- Delay the button prompt appearing a bit for a nicer effect
        if (showButtonPromptDelay <= 0) then
            drawButtonPrompt()
        else
            showButtonPromptDelay -= 1
        end
    end
end