local tick = require "lib.tick"

_G.lg = love.graphics
_G.lk = love.keyboard

CELL_SIZE     = 20
SCREEN_WIDTH  = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()

local snake
local fruit

function love.load()
  tick.rate = .3
  snake = {
    body = {{0,0}},
    facing = "right"
  }
end

function love.update()
end

function love.draw()
end
