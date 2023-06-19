colorChooser = 0

colors = {
    "FC3C3C", --red
    "FC3CCF", --pink
    "AF3CFC", --purple
    "4F3CFC", --blue
    "3CE9FC", --cyan
    "4FFC3C", --green
    "EFFC3C", --yellow
    "FC963C"  --orange
}

local style = "inner" -- inner, center, edge, outer

local width = 593 -- default: 593
local height = 11 -- default: 11

local bar_offset_x = 0 -- default: 0
local bar_offset_y = 0 -- default: 0

local border_color = "000000"
local border_thickness = 4 -- default: 4

local override_colors = true -- default: false
local override_p1_color = override_colors and "6fff4f" or nil
local override_p2_color = override_colors and "ff3030" or nil

local p1_offset_x = -26 -- default: -26
local p1_offset_y = 0 -- default: 0
local p2_offset_x = 26 -- default: 26
local p2_offset_y = 0 -- default: 0

--

local function to_hex(rgb)
	return string.format("%x", (rgb[1] * 0x10000) + (rgb[2] * 0x100) + rgb[3])
end

local sprite_border = "healthbar_border"
local sprite_p1 = "healthbar_p1"
local sprite_p2 = "healthbar_p2"

local bar_origin_x 
local bar_origin_y

local p_origin_y

function onCreatePost()

	initSaveData('newoptions', 'Settings Savedata')
	if getDataFromSave('newoptions', 'timebaronbeat') then
		override_p1_color = override_colors and "FFFFFF" or nil
	end

	setProperty('iconP1.visible', false)
	setProperty('iconP2.visible', false)
	setProperty("healthBarBG.visible", false)
	setProperty("healthBar.visible", false)
	
	bar_origin_x = (1280 - width) / 2
	bar_origin_y = getProperty("healthBarBG.sprTracker.y") - (height / 2)
	p_origin_y = getProperty("iconP1.y")
	
	makeLuaSprite(sprite_border, "",
		bar_origin_x - border_thickness + bar_offset_x,
		bar_origin_y - border_thickness + bar_offset_y
	)
	makeGraphic(sprite_border,
		width + (border_thickness * 2),
		height + (border_thickness * 2),
		border_color
	)
	addLuaSprite(sprite_border, true)
	setObjectCamera(sprite_border, "hud")
	setObjectOrder(sprite_border, 16)
	
	makeLuaSprite(sprite_p1, "",
		bar_origin_x + (width / 2) + bar_offset_x,
		bar_origin_y + bar_offset_y
	)
	makeGraphic(sprite_p1,
		(width / 2),
		height,
		override_colors and override_p1_color or to_hex(getProperty("boyfriend.healthColorArray"))
	)
	addLuaSprite(sprite_p1, true)
	setObjectCamera(sprite_p1, "hud")
	setObjectOrder(sprite_p1, 17)
	setProperty(sprite_p1 .. ".origin.x", getProperty(sprite_p1 .. ".width"))
	
	makeLuaSprite(sprite_p2, "",
		bar_origin_x + bar_offset_x,
		bar_origin_y + bar_offset_y
	)
	makeGraphic(sprite_p2,
		(width / 2),
		height,
		override_colors and override_p2_color or to_hex(getProperty("dad.healthColorArray"))
	) 
	addLuaSprite(sprite_p2, true)
	setObjectCamera(sprite_p2, "hud")
	setObjectOrder(sprite_p2, 17)
	setProperty(sprite_p2 .. ".origin.x", 0)

	positionTimebar(16, 696)
end

function onUpdatePost()
	local percent_p1 = (getProperty("healthBar.percent") / 100)
	local percent_p2 = 1 - percent_p1
	
	local scale_p1 = (percent_p1 * 2) + (percent_p1 < 1 and 0.01 or 0)
	local scale_p2 = percent_p2 * 2
	setProperty(sprite_p1 .. ".scale.x", scale_p1)
	setProperty(sprite_p2 .. ".scale.x", scale_p2)
	
	local real_width_p1 = getProperty(sprite_p1 .. ".width") * scale_p1
	local real_width_p2 = getProperty(sprite_p2 .. ".width") * scale_p2

	setProperty(sprite_border .. ".x", bar_origin_x - border_thickness + bar_offset_x)
	setProperty(sprite_border .. ".y", bar_origin_y - border_thickness + bar_offset_y)
	
	setProperty(sprite_p1 .. ".x", bar_origin_x + (width / 2) + bar_offset_x)
	setProperty(sprite_p1 .. ".y", bar_origin_y + bar_offset_y)
	
	setProperty(sprite_p2 .. ".x", bar_origin_x + bar_offset_x)
	setProperty(sprite_p2 .. ".y", bar_origin_y + bar_offset_y)
end

function positionTimebar(x, y)
	setProperty('timeBar.x', x)
	setProperty('timeBar.y', y)
	setProperty('timeBarBG.x', x)
	setProperty('timeBarBG.y', y)
end

function onBeatHit()
	if getDataFromSave('newoptions', 'timebaronbeat') then
		colorChooser = colorChooser + 1
		doTweenColor('healthbar', sprite_p1, colors[colorChooser], 0.5, 'linear');
		if colorChooser == #colors then
			colorChooser = 0
		end 
	end
end