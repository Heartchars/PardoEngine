-- original comment & script by Snirozu
-- https://gamebanana.com/questions/37875

-- edited by kommit
-- https://gamebanana.com/members/2028555

-- to edit the ratings, just change the text inside the thing like this: setRatingNameAlt("your rating here")
-- you can also edit the ratingPercents if you want to add more accuracy stuff to be more specific or something

function onUpdateScore(missed)
	ratingPercent = getProperty("ratingPercent")

	if getProperty("ratingName") ~= "?" then

		-- SFC 100% accuracy
		if ratingPercent == 1 then
			setRatingNameAlt("Bluey")

		-- 90% accuracy
        elseif ratingPercent > 0.9 then
			setRatingNameAlt("Cool!")

		-- 80% accuracy
        elseif ratingPercent > 0.8 then
			setRatingNameAlt("Normal!")

		-- 70% accuracy
        elseif ratingPercent > 0.7 then
			setRatingNameAlt("Good")

		-- 60% accuracy
        elseif ratingPercent > 0.6 then
			setRatingNameAlt("MUGH")

		-- 50% accuracy
        elseif ratingPercent > 0.5 then
			setRatingNameAlt("UGH")

		-- 40% accuracy
        elseif ratingPercent > 0.4 then
			setRatingNameAlt("OHSHIT")

		-- 30% accuracy
        elseif ratingPercent > 0.3 then
			setRatingNameAlt("Shit")

		-- 20% accuracy
        elseif ratingPercent > 0.2 then
			setRatingNameAlt("Shit")

		-- 10% accuracy
        elseif ratingPercent > 0.1 then
			setRatingNameAlt("You Suck!")

		-- 0% accuracy
        elseif ratingPercent == 0.0 then
			setRatingNameAlt("You Suck!")
		end
	else
		setRatingNameAlt(nil)
	end
end

function setRatingNameAlt(newRating)
	score = getProperty("songScore")
	songMisses = getProperty("songMisses")
	ratingPercent = getProperty("ratingPercent")
	ratingFC = getProperty("ratingFC")

	ratingDetails = ""

	if getProperty("ratingName") ~= "?" then
		addHaxeLibrary("Highscore")
		piss = runHaxeCode("Highscore.floorDecimal(" .. (ratingPercent * 100) .. ", 2)")
		ratingDetails = " (" .. piss .. "%) - " .. ratingFC
	end
	
	setProperty("scoreTxt.text", "Score: " .. score .. " | Misses: " .. songMisses .. " | Rating: " .. newRating .. ratingDetails)
end