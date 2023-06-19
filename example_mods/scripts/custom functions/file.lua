
    Functions in this code
    - Round and Truncate function (for accuracy and stuff)
    - Flash text (aka better debug print)


## Round and Truncate
    for accuracy: round((getProperty('ratingPercent') * 100), 2)
function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

## Flash text
locations:
    center: 180, 330
    topleft: 0, 0
    topRight: 460, 0
    bottomLeft: 0, 660
    bottomRight: 460, 660

function flashText(name, text, location, time, tween)
    --setup
    string.lower(location)
    tonumber(time)
    
    makeLuaText(name, text, 600, 195, 532);
	setTextSize(name, 40);
	setTextWidth(name, 900)
    setObjectCamera(name, 'other')
    
    if location == 'center' then
        setTextAlignment(name, 'center')
    elseif location == 'topleft' or location == 'bottomleft' then
        setTextAlignment(name, 'left')
    elseif location == 'topright' or location == 'bottomright' then
        setTextAlignment(name, 'right')
    end

    addLuaText(name)
    doTweenAlpha('fadeAway', name, 0, time, tween)
end


function createSprite(name, sprite, x, y, camera)
    makeLuaSprite(name, sprite, x, y)
    setObjectCamera(name, camera)
    addLuaSprite(name)
end

function createGraphic(name, width, height, color, camera)
    makeLuaSprite(name, nil, 0, 0)
    makeGraphic(name, width, height, color)
    setObjectCamera(name, camera)
    addLuaSprite(name)
end

function setPosition(name, x, y)
    if x == nil then
        setProperty(name..'.y', y)
    elseif y == nil then
        setProperty(name..'.x', x)
    else
        setProperty(name..'.x', x)
        setProperty(name..'.y', y)
    end
end

function addPosition(name, x, y, eq)
    setProperty(name..'.x', getProperty(name..'.x') + x)
    setProperty(name..'.y', getProperty(name..'.y') + y)
end

function substractPosition(name, x, y, eq)
    setProperty(name..'.x', getProperty(name..'.x') - x)
    setProperty(name..'.y', getProperty(name..'.y') - y)
end

function createText(name, text, x, y, camera, alignment, opacity, size, font)
    makeLuaText(name, text, 1000, x, y)
    setTextSize(name, size)
    setObjectCamera(name, camera)
    setTextFont(name, font)
    setTextAlignment(name, alignment)
    setProperty(name..'.alpha', opacity)
    addLuaText(name, true)
end