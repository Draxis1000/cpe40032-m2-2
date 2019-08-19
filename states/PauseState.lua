PauseState = Class{__includes = BaseState}

function PauseState:init()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    self.image = love.graphics.newImage('pause.png')
    self.x = VIRTUAL_WIDTH / 2 - 256
    self.y = VIRTUAL_HEIGHT / 2 - 256

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            bird = self.bird,
            pipepairs = self.pipepairs,
            lastY = self.lastY,
            timer = self.timer,
            score = self.score
        })
        currentState = 'play'
        sounds['pause']:stop()
    end
end

function PauseState:render()
    for k,pair in pairs(self.pipepairs) do
        pair:render()
    end
    self.bird:render()
    love.graphics.draw(self.image, self.x,self.y)
    love.graphics.setFont(flappyFont)
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press p to Resume Game.',0,80,VIRTUAL_WIDTH,'center')

end

function PauseState:enter(params)
    self.bird = params.bird
    self.pipepairs = params.pipePairs
    self.lastY = params.lastY
    self.timer = params.timer
    self.score = params.score
end
