module EvaluateMatches
	class Evaluate
		def initialize
			@feedback = ""
			@bool = []
		end

# Create array of bools for guesses in correct position.
# Create 2 arrays for incorrect values in both vars representing the guess and answer
# Compare both arrays and return count of matches (guesses that are correct but in wrong order)

		def evaluate_matches(answer, guess)
			a = ""
			b = ""
			4.times do |x = 0|
				answer[x] == guess[x] ? @bool.push(true) && @feedback << ("\e[31m■  \e[0m") : 
				@bool.push(false) && a << guess[x] && b << answer[x]
				x += 1
			end

			b.length.times do |x = 0|
			a.chars.sort[x] == b.chars.sort[x] ? @feedback << ("\e[37m■  \e[0m") && x += 1 : x += 1
			end
		return @feedback
		end
	end
end
