--[[
    ScoreState Class

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}
local low = love.graphics.newImage('medals/bronze.png')
local mid = love.graphics.newImage('medals/silver.png')
local high = love.graphics.newImage('medals/gold.png')
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
        currentState = 'countdown'
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    
    if self.score > 0 then
        if self.score < 10 then
            medal = low
        elseif self.score < 25 then
            medal = mid 
        elseif self.score < 40 then
            medal = high

        end
     love.graphics.draw(medal, VIRTUAL_WIDTH/2 -30, VIRTUAL_HEIGHT/2 -30)

    end

    love.graphics.printf('Press Enter to Play Again!', 0, 190, VIRTUAL_WIDTH, 'center')
end