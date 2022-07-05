module EvaluateMatches
	class Evaluate
		def initialize
			@feedback = ""
			@bool = []
		end

# 1. Create array of bools for guesses in correct position.
# 2. Create 2 arrays for incorrect values in both vars representing the guess and answer
# 3. Compare both arrays and return count of matches (guesses that are correct but in wrong order)

		def evaluate_matches(answer, guess)
			a = ""
			b = ""

			if answer == guess
				abort "Winner!!!"
			end

			4.times do |x = 0|
				answer[x] == guess[x] ? @bool.push(true) && @feedback << ("\e[31m■  \e[0m") : 
				@bool.push(false) && a << guess[x] && b << answer[x]
				x += 1
			end

			a.chars.intersection(b.chars).length.times do
				@feedback << ("\e[37m■  \e[0m")
			end
		return @feedback
		end
	end
end