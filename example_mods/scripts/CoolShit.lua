function onCreate()	
	ez = 'v1.3.2'

	amongus = {
		'freeplay',
		'mods',
		'options',
	}

    setProperty('skipArrowStartTween', true)
	setPropertyFromClass('MainMenuState', 'optionShit', amongus) --this didn't work :/
	--setPropertyFromClass('MainMenuState', 'psychEngineVersion', '0.5.2h | Blue Side TakeOver '..ez) removed bc an outdated warning appears
	setPropertyFromClass("openfl.Lib", "application.window.title", "Pardo Engine "..ez.." | Jogando [".. songName .."]")
    if songName == 'Settings' then
        setPropertyFromClass("openfl.Lib", "application.window.title", "Pardo Engine "..ez.." | Configurações")
    end
end

function onGameOver()
	cameraFlash('other', '750800', 1)
	playSound('fnf_loss_sfx', 1.9)
	restartSong(false)
	return Function_Stop
end

function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Pardo Engine "..ez.." | Principal")
end

function onCreatePost() --hud shit
	setProperty('healthBar.x', getProperty('healthBar.x') - 300)
	setProperty('healthBarBG.x', getProperty('healthBarBG.x') - 300)
	setTextFont('scoreTxt', 'phantom full.ttf')
	setProperty('scoreTxt.scale.x', 0.9)
	setProperty('scoreTxt.scale.y', 0.8)
	setProperty('timeBar.x', getProperty('healthBar.x'));
	setProperty('timeBar.y', getProperty('healthBar.y') - 50);
	setProperty('timeTxt.y', 660)
	setProperty('timeTxt.x', -150)
end