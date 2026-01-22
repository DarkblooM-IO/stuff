local tick = require "lib.tick"

_G.lg = love.graphics
_G.lk = love.keyboard

CELL_SIZE     = 20
SCREEN_WIDTH  = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()
DIR = {UP = "up", LEFT = "left", DOWN = "down", RIGHT = "right"}

local snake
local fruit

function love.load()
  tick.rate = .1
  snake = {
    body = {{0,0}},
    facing = "right",
    score = 0,
    dead = false
  }
end

function love.update()
  if snake.dead then return end

  local f = snake.facing
  local pos = snake.body[1]
  local newpos

  if f == DIR.UP then newpos = {pos[1], pos[2]-1} end
  if f == DIR.LEFT then newpos = {pos[1]-1, pos[2]} end
  if f == DIR.DOWN then newpos = {pos[1], pos[2]+1} end
  if f == DIR.RIGHT then newpos = {pos[1]+1, pos[2]} end

  table.insert(snake.body, 1, newpos)
  if #snake.body > snake.score then table.remove(snake.body, #snake.body) end
end

function love.draw()
  for _,pos in pairs(snake.body) do
    local x = pos[1]*CELL_SIZE
    local y = pos[2]*CELL_SIZE
    lg.rectangle("fill", x,y, CELL_SIZE,CELL_SIZE)
  end
end

function love.keypressed(key,scancode)
  if scancode == "escape" then love.event.quit() end

  local f = snake.facing
  if scancode == "w" and f ~= DIR.DOWN  then snake.facing = DIR.UP    end
  if scancode == "a" and f ~= DIR.RIGHT then snake.facing = DIR.LEFT  end
  if scancode == "s" and f ~= DIR.UP    then snake.facing = DIR.DOWN  end
  if scancode == "d" and f ~= DIR.LEFT  then snake.facing = DIR.RIGHT end
end
