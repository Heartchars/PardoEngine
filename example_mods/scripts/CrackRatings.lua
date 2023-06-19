--Image File Directories, MUST BE IN "mods/images/hud-elements" !!!
--big positive about this shit is that its really customizable, YEEEEEEEEEEEE
PlayerRatingSheet='hud-elements/BaseSheet'

--Positions, configure however!
local PlayerRatingPosX = 50

local ComboFontScale = 40

local ScoreFontScale = 25
local eScoreTextX =  0
local pScoreTextX =  975
local ScoreTextY = 50

local DadMissColor = '791F20' --miss color for the dad randomly missing notes

local Sync_sick = 0
local Sync_good = 0
local Sync_bad = 0
local Sync_shit = 0
local Sync_miss = 0 --added this because missing pops up a "Sick!" for some reason

local P_Combo = 0

--my settings
local comboString = 'COMBO'

-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false

function onCreatePost() --precaching of images and stuff
	
	--debugPrint(getPropertyFromClass('ClientPrefs', 'comboOffset'))
	ifthisworksillcutmyballs = {-600, -600, -600, -600} --it actually didn't work (it did)
	setPropertyFromClass('ClientPrefs', 'comboOffset', ifthisworksillcutmyballs)

	GeneratePlayerRatingSprites()
	
	makeLuaText('pComboText', P_Combo..' '..comboString, 300, 0, 0)
	setTextAlignment('pComboText', 'center')
	setTextSize('pComboText', ComboFontScale)
	setObjectCamera('pComboText', 'hud')
	setProperty('pComboText.alpha', 0)
	addLuaText('pComboText')
	setTextFont('pComboText', 'phantom full.ttf')
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'miss_wait' then
		characterPlayAnim('dad', 'idle', true)
		setProperty('dad.color', getColorFromHex('FFFFFF'));
		setProperty('dad.animation.curAnim.paused', false)
		setProperty('dad.specialAnim',false)
	end
	if tag == 'DummyNoteUnHide' then
		for Uncloak = 0,3 do
			setPropertyFromGroup('opponentStrums', Uncloak, 'visible', true)
			setProperty('DummyNote'..Uncloak..'.visible', false)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
		--i couldnt find any other way to "get" the rating of the most recent note so here
		if Sync_sick ~= getProperty('sicks') then
			P_RatingAnim = 'pSick'
			Sync_sick = getProperty('sicks')
		elseif  Sync_good ~= getProperty('goods') then
			P_RatingAnim = 'pGood'
			Sync_good = getProperty('goods')
		elseif  Sync_bad ~= getProperty('bads') then
			P_RatingAnim = 'pBad'
			Sync_bad = getProperty('bads')
		elseif Sync_shit ~= getProperty('shits') then
			P_RatingAnim = 'pShit'
			Sync_shit = getProperty('shits')
		end

		P_Combo=P_Combo+1
		setTextString('pComboText', P_Combo..' '..comboString)

		objectPlayAnimation('P_RatingScore', P_RatingAnim, true)
		P_RatingPopup()
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	-- Called after the note miss calculations
	-- Player missed a note by letting it go offscreen
	P_Combo = 0
	setTextString('pComboText', P_Combo..' '..comboString)
	P_RatingTexture = P_MissImage
	Sync_miss = getProperty('misses')
	--GeneratePlayerRatingSprites()
	P_RatingAnim = 'pMiss'
	objectPlayAnimation('P_RatingScore', P_RatingAnim, true)
	P_RatingPopup()
end

function GeneratePlayerRatingSprites()

	makeAnimatedLuaSprite('P_RatingScore', PlayerRatingSheet, 0, 0)
	screenCenter('P_RatingScore', 'x')
	setProperty('P_RatingScore.x', getProperty('P_RatingScore.x')+PlayerRatingPosX)
	setObjectCamera('P_RatingScore', 'hud')
	scaleObject('P_RatingScore', 0.65, 0.65)
	setProperty('P_RatingScore.alpha', 0)
	
	addAnimationByPrefix('P_RatingScore', 'pSick', 'SickRating', 24, false)
	addAnimationByPrefix('P_RatingScore', 'pGood', 'GoodRating', 24, false)
	addAnimationByPrefix('P_RatingScore', 'pBad', 'BadRating', 24, false)
	addAnimationByPrefix('P_RatingScore', 'pShit', 'ShitRating', 24, false)
	addAnimationByPrefix('P_RatingScore', 'pMiss', 'MissRating', 24, false)
	
	addLuaSprite('P_RatingScore', true)
	
end

function P_RatingPopup()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') then
		x_location = 150
		y_location = 0
	else
		x_location = 500
		y_location = 0
	end

	setProperty('P_RatingScore.x', x_location)
	setProperty('pComboText.x', x_location - 20)
	
	setProperty('P_RatingScore.y', y)
	setProperty('pComboText.y', y_location + 100)

	setProperty('P_RatingScore.alpha', 0)
	setProperty('P_RatingScore.alpha', 1)
	scaleObject('P_RatingScore', 0.75, 0.75)
	doTweenAlpha('PlayerRatingFade','P_RatingScore', 0, 0.4, 'linear')
	--doTweenX('PlayerRatingScaleX', 'P_RatingScore.scale', 0.65, 0.2, 'circInOut')
	--doTweenY('PlayerRatingScaleY', 'P_RatingScore.scale', 0.65, 0.2, 'circInOut')

	setProperty('pComboText.alpha', 0)
	setProperty('pComboText.alpha', 0.6)
	scaleObject('pComboText', 1.1, 1.1)
	doTweenAlpha('pComboFade','pComboText', 0, 0.4, 'linear')
	doTweenX('pComboScaleX', 'pComboText.scale', 1, 0.2, 'circInOut')
	doTweenY('pComboScaleY', 'pComboText.scale', 1, 0.2, 'circInOut')
end
