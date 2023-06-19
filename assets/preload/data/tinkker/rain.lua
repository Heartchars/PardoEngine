function onCreate()
	makeAnimatedLuaSprite('rain', 'rain', 0, 0);
	setLuaSpriteScrollFactor('rain', 0.3, 0.3);
	scaleObject('rain', 2.30, 2.30);

	makeAnimatedLuaSprite('splash', 'splash', 0, 50);

	addLuaSprite('splash', true);
	addAnimationByPrefix('splash', 'loop', 'splash loop', 15, true);
	addLuaSprite('rain', true);
	addAnimationByPrefix('rain', 'loop', 'rain loop', 15, true);
end