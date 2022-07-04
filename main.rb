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
    	4.times do
      		random_choice = COLOURS.sample
      		@choice << random_choice
    	end
    	puts @choice
    	@cleaned_computer_choice = (@choice[6] + @choice[18] + @choice[30] + @choice[42]).to_s
  	end

  	def get_player_guess
    	puts "Please enter your guess! e.g. 'RGBY' or 'MTBR'"
    	player_guess = gets.chomp
    	check_valid_guess(player_guess)
  	end


  	def check_valid_guess(player_guess)
    	cleaned_player_choice = player_guess.gsub(/[^RGBYMT]/i, "").strip.upcase
    
    	if cleaned_player_choice.length == 4 
      	evaluate_matches(cleaned_player_choice)
    	else
      	(puts "Invalid input")
    	end
  	end

  	def evaluate_matches(cleaned_player_choice)
		@evaluation = Evaluate.new.evaluate_matches(@cleaned_computer_choice, cleaned_player_choice)
		@round += 1
		draw_board(cleaned_player_choice)
		
	end

  	def draw_board(cleaned_player_choice)
    	ascii_player_choice = ""
    	4.times do |x = 0|
      		ascii_player_choice << COLOURS.find { |y| y.match(/#{cleaned_player_choice[x]}/) }
      		x += 1
    	end

    	@board.append([@round.to_s + ". " + ascii_player_choice + "  " + @evaluation])
    	puts @board
    	@evaluation.clear
    	check_round_count
  	end

  	def check_round_count
    	@round == 12 ? "Game Over!" : get_player_guess
  	end
end

game = Game.new
game.random_colours
game.get_player_guess
