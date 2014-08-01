-- Hump gamestate - http://vrld.github.io/hump/#hump.gamestate
Gamestate = require "hump.gamestate"

-- Game scenes
local mainMenuScene = require "mainMenuScene"
local matchScene = require "matchScene"

function love.load()
	-- To see live sublime console.
	io.stdout:setvbuf("no")

	-- init random
	math.randomseed(os.time())

  Gamestate.registerEvents()
  Gamestate.switch(matchScene)
end

-- Gamestate is propagating this to the current scene
function love.draw()
end

-- Gamestate is propagating this to the current scene
function love.update(dt)
end

-- Gamestate is propagating this to the current scene
function love.keypressed(k)
end