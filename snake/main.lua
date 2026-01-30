love.mouse.setVisible(false)

local tick = require "lib.tick"
local json = require "lib.json"

_G.lg  = love.graphics
_G.lfs = love.filesystem

CELL_SIZE     = 20
SCREEN_WIDTH  = lg.getWidth()
SCREEN_HEIGHT = lg.getHeight()
DIR           = {UP = "up", LEFT = "left", DOWN = "down", RIGHT = "right"}
GAME_SPEED    = .09
BG_COLOR      = {163,190,140}
SNAKE_COLOR   = {HEAD = {129,161,193}, BODY = {94,129,172}}
FRUIT_COLOR   = {191,97,106}

CFG_FILE = "config.json"
CFG = lfs.getInfo(CFG_FILE) and json.decode(lfs.read(CFG_FILE)) or {
  KEYBINDS = {
    UP      = "up",
    LEFT    = "left",
    DOWN    = "down",
    RIGHT   = "right",
    PAUSE   = "space",
    RESTART = "r",
    QUIT    = "escape"
  },
  HIGH_SCORE = 0
}
KEYBINDS = CFG["KEYBINDS"]

local snake
local fruit
local pause

local function setColor(rgba)
  lg.setColor(love.math.colorFromBytes(unpack(rgba)))
end

local function drawCell(pos, color, mode)
  local x = pos[1]*CELL_SIZE
  local y = pos[2]*CELL_SIZE
  setColor({0,0,0})
  lg.rectangle("line", x,y, CELL_SIZE,CELL_SIZE)
  setColor(color or {255,255,255})
  lg.rectangle(mode or "fill", x,y, CELL_SIZE,CELL_SIZE)
end

local function sameCell(c1, c2)
  if c1 and c2 then
    return c1[1] == c2[1] and c1[2] == c2[2]
  end
  return false
end

local function randomCell()
  local newcell = {math.random(1,(SCREEN_WIDTH/CELL_SIZE)-1),math.random(1,(SCREEN_HEIGHT/CELL_SIZE)-1)}
  local collide = false
  for _,cell in pairs(snake.body) do if sameCell(newcell,cell) then collide = true end end
  if sameCell(newcell,fruit) then collide = true end
  return collide and randomCell() or newcell
end

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

  lg.setFont(lg.newFont(16))
end

function love.quit()
  lfs.write(CFG_FILE, json.encode(CFG))
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
    if snake.score > CFG["HIGH_SCORE"] then CFG["HIGH_SCORE"] = snake.score end
  elseif newpos[1] < 0 or newpos[1] >= SCREEN_WIDTH/CELL_SIZE or newpos[2] < 0 or newpos[2] >= SCREEN_HEIGHT/CELL_SIZE or snake.collides(newpos) then
    snake.dead = true
    return
  end

  -- update snake position
  table.insert(snake.body, 1, newpos)
  if #snake.body > snake.score+1 then table.remove(snake.body, #snake.body) end
end

function love.draw()
  -- draw background
  lg.clear(love.math.colorFromBytes(unpack(BG_COLOR)))

  -- draw snake
  for k,pos in pairs(snake.body) do
    local color = k == 1 and SNAKE_COLOR.HEAD or SNAKE_COLOR.BODY
    drawCell(pos, color)
  end

  -- draw fruit
  drawCell(fruit, FRUIT_COLOR)

  -- print game status
  if snake.dead or pause then
    setColor({0,0,0})
    local msg = string.format(
      [[%s
score: %d (best: %d)
keybinds:
  - move:
    - up: %s
    - left: %s
    - down: %s
    - right: %s
  - pause: %s
  - restart: %s
  - quit: %s]],
      snake.dead and "you died!" or "game paused",
      snake.score, CFG["HIGH_SCORE"],
      KEYBINDS.UP,KEYBINDS.LEFT,KEYBINDS.DOWN,KEYBINDS.RIGHT,
      KEYBINDS.PAUSE,
      KEYBINDS.RESTART,
      KEYBINDS.QUIT
    )
    lg.print(msg, 10,10)
  end
end

function love.keypressed(key,scancode)
  -- quit game
  if scancode == KEYBINDS.QUIT then love.event.quit() end

  -- pause
  if scancode == KEYBINDS.PAUSE and not snake.dead then
    pause = not pause
    return
  end

  -- restart
  if scancode == KEYBINDS.RESTART then
    love.load()
    return
  end

  -- set next direction checking for opposites
  local f = snake.facing
  if     scancode == KEYBINDS.UP    and f ~= DIR.DOWN  then snake.buffer = DIR.UP  
  elseif scancode == KEYBINDS.LEFT  and f ~= DIR.RIGHT then snake.buffer = DIR.LEFT
  elseif scancode == KEYBINDS.DOWN  and f ~= DIR.UP    then snake.buffer = DIR.DOWN
  elseif scancode == KEYBINDS.RIGHT and f ~= DIR.LEFT  then snake.buffer = DIR.RIGHT end
end

function love.focus(f) if not f then pause = true end end
