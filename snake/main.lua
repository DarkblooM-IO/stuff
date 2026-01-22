local tick = require "lib.tick"

_G.lg = love.graphics
_G.lk = love.keyboard

CELL_SIZE     = 20
SCREEN_WIDTH  = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()
DIR           = {UP = "up", LEFT = "left", DOWN = "down", RIGHT = "right"}
GAME_SPEED    = .15
SNAKE_COLOR   = {163,190,140}
FRUIT_COLOR   = {191,97,106}

local function setColor(rgba)
  lg.setColor(love.math.colorFromBytes(unpack(rgba)))
end

local function randomCell()
  return {math.random(1,(SCREEN_WIDTH/CELL_SIZE)-1),math.random(1,(SCREEN_HEIGHT/CELL_SIZE)-1)}
end

local snake
local fruit

function love.load()
  math.randomseed(os.time())

  tick.rate = GAME_SPEED
  snake = {
    body   = {{0,0}},
    facing = "",
    score  = 0,
    dead   = false,
    buffer = "right"
  }
  fruit = randomCell()
end

function love.update()
  -- don't do anything if dead
  if snake.dead then return end

  -- apply next direction
  snake.facing = snake.buffer

  local f   = snake.facing
  local pos = snake.body[1]
  local newpos

  -- create next position based on direction
  if f == DIR.UP    then newpos = {pos[1],   pos[2]-1} end
  if f == DIR.LEFT  then newpos = {pos[1]-1, pos[2]}   end
  if f == DIR.DOWN  then newpos = {pos[1],   pos[2]+1} end
  if f == DIR.RIGHT then newpos = {pos[1]+1, pos[2]}   end

  if newpos[1] == fruit[1] and newpos[2] == fruit[2] then
    fruit = randomCell() -- todo: spawn new fruit
    snake.score = snake.score+1
  end

  -- update snake position
  table.insert(snake.body, 1, newpos)
  if #snake.body > snake.score+1 then table.remove(snake.body, #snake.body) end
end

function love.draw()
  local x,y

  -- draw fruit
  setColor(FRUIT_COLOR)
  x = fruit[1]*CELL_SIZE
  y = fruit[2]*CELL_SIZE
  lg.rectangle("fill", x,y, CELL_SIZE,CELL_SIZE)

  -- draw snake
  setColor(SNAKE_COLOR)
  for _,pos in pairs(snake.body) do
    x = pos[1]*CELL_SIZE
    y = pos[2]*CELL_SIZE
    lg.rectangle("fill", x,y, CELL_SIZE,CELL_SIZE)
  end

  -- reset color
  setColor({0,0,0})
end

function love.keypressed(key,scancode)
  if scancode == "escape" then love.event.quit() end

  -- set next direction checking for opposites
  local f = snake.facing
  if scancode == "w" and f ~= DIR.DOWN  then snake.buffer = DIR.UP    end
  if scancode == "a" and f ~= DIR.RIGHT then snake.buffer = DIR.LEFT  end
  if scancode == "s" and f ~= DIR.UP    then snake.buffer = DIR.DOWN  end
  if scancode == "d" and f ~= DIR.LEFT  then snake.buffer = DIR.RIGHT end
end
