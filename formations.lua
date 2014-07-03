local formations = {}

formations["4-4-2a"] = {
	-- Goalkeeper
	{ defense = { x = 300, y = 70 }, attack = { x = 300, y = 100 }},

	-- 4 Defenders
	{ defense = { x = 140, y = 140}, attack = { x = 140, y = 380 }},
	{ defense = { x = 260, y = 120}, attack = { x = 260, y = 340 }},
	{ defense = { x = 340, y = 120}, attack = { x = 340, y = 340 }},
	{ defense = { x = 460, y = 140}, attack = { x = 460, y = 380 }},

	-- 4 Midfielders
	{ defense = { x = 100, y = 240}, attack = { x = 100, y = 540 }},
	{ defense = { x = 230, y = 220}, attack = { x = 230, y = 520 }},
	{ defense = { x = 370, y = 220}, attack = { x = 370, y = 520 }},
	{ defense = { x = 500, y = 240}, attack = { x = 500, y = 540 }},

	-- 2 Forwards
	{ defense = { x = 220, y = 330}, attack = { x = 230, y = 630 }},
	{ defense = { x = 360, y = 340}, attack = { x = 370, y = 640 }},
}

formations["4-3-3a"] = {
	-- Goalkeeper
	{ defense = { x = 300, y = 70}, attack = { x = 300, y = 120 }},

	-- 4 Defenders
	{ defense = { x = 120, y = 140}, attack = { x = 120, y = 400 }},
	{ defense = { x = 250, y = 120}, attack = { x = 250, y = 370 }},
	{ defense = { x = 350, y = 120}, attack = { x = 350, y = 370 }},
	{ defense = { x = 480, y = 140}, attack = { x = 480, y = 400 }},

	-- 3 Midfielders
	{ defense = { x = 160, y = 220}, attack = { x = 160, y = 540 }},
	{ defense = { x = 300, y = 230}, attack = { x = 300, y = 540 }},
	{ defense = { x = 440, y = 220}, attack = { x = 440, y = 540 }},

	-- 3 Forwards
	{ defense = { x = 180, y = 330}, attack = { x = 180, y = 630 }},
	{ defense = { x = 300, y = 350}, attack = { x = 300, y = 630 }},
	{ defense = { x = 420, y = 330}, attack = { x = 420, y = 630 }},
}

return formations