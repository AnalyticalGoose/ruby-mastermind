require_relative 'variables.rb'
require_relative 'evaluation.rb'

include Variables
include EvaluateMatches

class Game
  	def initialize
    	@round = 0
    	@board = [" "]
    	@choice = ""
    	@cleaned_computer_choice = ""
    	@evaluation = ""
  	end

  	def random_colours 
    	4.times { @choice << COLOURS.sample } # Generate 4 random colours
  	end

  	def get_player_guess
    	puts "Please enter your guess! e.g. 'RGBY' or 'MTBR'. Available colours are: R,G,B,Y,M,T"
    	player_guess = gets.chomp
    	string_cleanup(player_guess)
  	end

	def string_cleanup(player_guess)

		# Cleanup the user input to remove spaces, symbols and other characters
		# Generate a plaintext string of the secret code for future use

		cleaned_player_choice = player_guess.gsub(/[^RGBYMT]/i, "").strip.upcase
		@cleaned_computer_choice = (@choice[6] + @choice[18] + @choice[30] + @choice[42]).to_s
		check_valid_guess(cleaned_player_choice)
	end

  	def check_valid_guess(cleaned_player_choice)   
    	if cleaned_player_choice.length == 4 
      		evaluate_matches(cleaned_player_choice)
    	else
      		(puts "Invalid input")
    	end
  	end

  	def evaluate_matches(cleaned_player_choice)
		if @cleaned_computer_choice == cleaned_player_choice
			abort "Winnnnnnerrrrrr!"
		end
			@evaluation = Evaluate.new.evaluate_matches(@cleaned_computer_choice, cleaned_player_choice)
			@round += 1
			colourise_choice(cleaned_player_choice)
	end

	def colourise_choice(cleaned_player_choice) # Generate coloured string to print on the game-board
		ascii_player_choice = ""
		4.times do |x = 0|
			ascii_player_choice << COLOURS.find { |y| y.match(/#{cleaned_player_choice[x]}/) }
			x += 1
	 	 end
		draw_board(ascii_player_choice)
	end

  	def draw_board(ascii_player_choice)	
    	@board.append([@round.to_s + ". " + ascii_player_choice + "  " + @evaluation])
    	puts @board
    	@evaluation.clear
    	check_round_count
  	end

  	def check_round_count
    	@round == 12 ? "Game Over!" : get_player_guess 
  	end
end