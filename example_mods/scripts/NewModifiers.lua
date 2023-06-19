luatexts = {
    'description',
    'bottext',
    'playdad',
    'settingstext',
    'endtext',
    'restarttext',
}

thehud = {
    'healthBar',
    'healthBarBG',
    'timeBar',
    'timeTxt',
    'iconP1',
    'iconP2'
}


function onCreate()
    if getProperty('cpuControlled') then
        setPropertyFromClass('flixel.FlxG', 'autoPause', true)
    else
        setPropertyFromClass('flixel.FlxG', 'autoPause', false)
    end
end

function onCreate()

    setProperty('songSpeedType', 'multiplicative') --uncompatible with constant scrollspeed 

    if songName ~= 'Settings' then
        scroll = 1
        scrollString = '< F1 |  Scrollspeed : x'..scroll..'  | F2'
        isBot = getProperty('cpuControlled')
        secretBot = getProperty('cpuControlled')
        botString = 'F3 |  Botplay'
        opplay = false
        ishide = false

        initSaveData('songsaver', 'ModpackSavedata')

        makeLuaText('description', scrollString, 1000, 268, 680)
        setTextAlignment('description', 'right')
        setTextFont('description', 'phantom full.ttf')
        setTextSize('description', 20)
        setObjectCamera('description', 'other')
        addLuaText('description')
        setProperty('description.alpha', 0.7)
        
        makeLuaText('bottext', botString, 1000, 268, 650)
        setTextAlignment('bottext', 'right')
        setTextFont('bottext', 'phantom full.ttf')
        setTextSize('bottext', 20)
        setObjectCamera('bottext', 'other')
        addLuaText('bottext')
        setProperty('bottext.alpha', 0.7)

        makeLuaText('playdad', 'F4 |  Play as opponent', 1000, 268, 620)
        setTextAlignment('playdad', 'right')
        setTextFont('playdad', 'phantom full.ttf')
        setTextSize('playdad', 20)
        setObjectCamera('playdad', 'other')
        addLuaText('playdad')
        setProperty('playdad.alpha', 0.7)

        makeLuaText('settingstext', 'F5 |  Open Settings Menu', 1000, 268, 590)
        setTextAlignment('settingstext', 'right')
        setTextFont('settingstext', 'phantom full.ttf')
        setTextSize('settingstext', 20)
        setObjectCamera('settingstext', 'other')
        addLuaText('settingstext')
        setProperty('settingstext.alpha', 0.7)
        
        makeLuaText('endtext', 'F6 |  Finish Song', 1000, 268, 560)
        setTextAlignment('endtext', 'right')
        setTextFont('endtext', 'phantom full.ttf')
        setTextSize('endtext', 20)
        setObjectCamera('endtext', 'other')
        addLuaText('endtext')
        setProperty('endtext.alpha', 0.7)
        
        makeLuaText('restarttext', 'TAB |  Hide/Show menu', 1000, 268, 530)
        setTextAlignment('restarttext', 'right')
        setTextFont('restarttext', 'phantom full.ttf')
        setTextSize('restarttext', 20)
        setObjectCamera('restarttext', 'other')
        addLuaText('restarttext')
        setProperty('restarttext.alpha', 0.7)
    end

    if isBot then
        setTextColor('bottext', '7FFF8C')
    elseif not isBot then
        setTextColor('bottext', 'FFFFFF')
    end
end

function onUpdatePost()

    --scrollspeed
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F2') and scroll < 10 then
        scroll = (getProperty(scroll) + 0.1)
        triggerEvent('Change Scroll Speed', scroll, 0.1);
        scrollString = '< F1 |  Scrollspeed : x'..scroll..'  | F2'
        setTextString('description', scrollString)
        playSound('scrollMenu', 1.9)
        playSound('scrollMenu', 1.9)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F1') and scroll > 0.2 then
        scroll = (getProperty(scroll) - 0.1)
        triggerEvent('Change Scroll Speed', scroll, 0.1);
        scrollString = '< F1 |  Scrollspeed : x'..scroll..'  | F2'
        setTextString('description', scrollString)
        playSound('scrollMenu', 1.9)
        playSound('scrollMenu', 1.9)
    end

    --scrollspeed x10 
    if getPropertyFromClass('flixel.FlxG', 'keys.pressed.F12') and scroll < 10 then
        scroll = (getProperty(scroll) + 0.1)
        triggerEvent('Change Scroll Speed', scroll, 0.1);
        scrollString = '< F1 | Scrollspeed : x'..scroll..' | F2'
        setTextString('description', scrollString)
        playSound('scrollMenu', 1.9)
        playSound('scrollMenu', 1.9)
    elseif getPropertyFromClass('flixel.FlxG', 'keys.pressed.F11') and scroll > 0.2 then
        scroll = (getProperty(scroll) - 0.1)
        triggerEvent('Change Scroll Speed', scroll, 0.1);
        scrollString = '< F1 | Scrollspeed : x'..scroll..' | F2'
        setTextString('description', scrollString)
        playSound('scrollMenu', 1.9)
        playSound('scrollMenu', 1.9)
    end

    --botplay toggler (this is highly abusable but who cares, lol)
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F3') and isBot then
        setProperty('cpuControlled', false)
        setTextColor('bottext', 'FFFFFF')
        setProperty('botplayTxt.visible', false)
        isBot = false
        secretBot = false
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F3') and not isBot then
        setProperty('cpuControlled', true)
        setTextColor('bottext', '7FFF8C')
        setProperty('botplayTxt.visible', true)
        isBot = true
        secretBot = true
    end

    --play as opponent
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F4') and not opplay then
        setTextColor('playdad', '7FFF8C')
        opplay = true
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F4') and opplay then
        setTextColor('playdad', 'FFFFFF')
        opplay = false
    end

    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F5') and songName ~= 'Settings' then
        debugPrint(difficulty)
        setDataFromSave('songsaver', 'song', songName)
        loadSong('Settings', -1)
    end
    
    --hide show 
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') and not ishide then
        for i=1,#luatexts do
        setProperty(luatexts[i]..'.visible', false) 
        ishide = true
        end
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') and ishide then
        for i=1,#luatexts do
        setProperty(luatexts[i]..'.visible', true) 
        ishide = false
        end
    end
end
