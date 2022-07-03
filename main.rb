require_relative 'variables.rb'

include Variables

# puts BOARD

class Game
  def initialize
    @choice = ""
    @cleaned_computer_choice = ""
  end

  def random_colours 
    4.times do
      random_choice = COLOURS.sample
      @choice << random_choice
    end
    puts @choice
    puts @cleaned_computer_choice = (@choice[6] + @choice[18] + @choice[30] + @choice[42]).to_s

  end

  def get_player_guess
    "Please enter your guess! e.g. 'RGBY' or 'MTBR'"
    player_guess = gets.chomp
    check_player_guess(player_guess)
  end


  def check_player_guess(player_guess)
    cleaned_player_choice = player_guess.gsub(/[^RGBYMT]/i, "").strip.upcase
    puts cleaned_player_choice
    
    if cleaned_player_choice.length == 4 
      (puts "valid")
    else
      (puts "Invalid input")
    end
  end
end

game = Game.new
game.random_colours
# game.get_player_guess
# game.check_player_guess("[r], [G], [b], [Y]")