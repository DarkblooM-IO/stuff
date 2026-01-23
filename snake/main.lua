love.mouse.setVisible(false)

local tick = require "lib.tick"

_G.lg = love.graphics

CELL_SIZE     = 20
SCREEN_WIDTH  = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()
DIR           = {UP = "up", LEFT = "left", DOWN = "down", RIGHT = "right"}
GAME_SPEED    = .09
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
local pause

function love.load()
  math.randomseed(os.time())

  tick.rate = GAME_SPEED

  snake = {
    body   = {{1,1}},
    facing = "",
    score  = 0,
    dead   = false,
    buffer = "right"
  }
  snake.collides = function (pos)
    for _,cell in pairs(snake.body) do
      if pos[1] == cell[1] and pos[2] == cell[2] then return true end
    end
    return false
  end

  fruit = randomCell()

  pause = false
end

function love.update(dt)
  -- don't do anything if dead
  if snake.dead or pause then return end

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
    fruit = randomCell()
    snake.score = snake.score+1
  elseif newpos[1] < 0 or newpos[1] >= SCREEN_WIDTH/CELL_SIZE or newpos[2] < 0 or newpos[2] >= SCREEN_HEIGHT/CELL_SIZE or snake.collides(newpos) then
    snake.dead = true
    return
  end

  -- update snake position
  table.insert(snake.body, 1, newpos)
  if #snake.body > snake.score+1 then table.remove(snake.body, #snake.body) end
end

function love.draw()
  local x,y

  -- draw snake
  for _,pos in pairs(snake.body) do
    x = pos[1]*CELL_SIZE
    y = pos[2]*CELL_SIZE
    setColor({0,0,0})
    lg.rectangle("line", x,y, CELL_SIZE,CELL_SIZE)
    setColor(SNAKE_COLOR)
    lg.rectangle("fill", x,y, CELL_SIZE,CELL_SIZE)
  end

  -- draw fruit
  x = fruit[1]*CELL_SIZE
  y = fruit[2]*CELL_SIZE
  setColor(FRUIT_COLOR)
  lg.rectangle("fill", x,y, CELL_SIZE,CELL_SIZE)

  -- print game status
  setColor({255,255,255})
  if snake.dead or pause then
    lg.print(snake.dead and "you died!" or "game paused", 10,10)
    lg.print(string.format("score: %d", snake.score), 10,30)
    lg.print("press r to restart", 10,50)
  end
end

function love.keypressed(key,scancode)
  -- quit game
  if scancode == "escape" then love.event.quit() end

  -- pause
  if scancode == "p" and not snake.dead then
    pause = not pause
    return
  end

  -- restart
  if scancode == "r" then
    love.load()
    return
  end

  -- set next direction checking for opposites
  local f = snake.facing
  if     scancode == "w" and f ~= DIR.DOWN  then snake.buffer = DIR.UP  
  elseif scancode == "a" and f ~= DIR.RIGHT then snake.buffer = DIR.LEFT
  elseif scancode == "s" and f ~= DIR.UP    then snake.buffer = DIR.DOWN
  elseif scancode == "d" and f ~= DIR.LEFT  then snake.buffer = DIR.RIGHT end
end

function love.focus(f)
  if not f then pause = true end
end
