local tick = require "lib.tick"

_G.lg = love.graphics
_G.lk = love.keyboard

CELL_SIZE = 20
SCREEN_WIDTH = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()

local grid
local snake
local fruit
local x

function love.load()
  tick.rate = .3
  x = 0
end

function love.update(dt)
  x = x+1
end

function love.draw()
  lg.print(x, 10,10)
end
