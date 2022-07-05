require_relative "main.rb"
require_relative "solver.rb"

include SolverModule

class GameLoops < Game
    def initialize
        @first_guess = "RRGG"
        @round = 1
        @code = ""
        @solver = Solver.new
    end

    def game_mode
        puts "\e[31m================================ MASTERMIND ================================\e[0m
        Would you like to be the code-maker or breaker? Type B or M
\e[31m============================================================================\e[0m"
        game_choice = gets.chomp.upcase
        
        if game_choice == "B"
            breaker_loop
        elsif game_choice == "M"
            maker_start
        else
            puts "Invalid input, please try again."
            game_mode
        end
    end

    def breaker_loop
        game = Game.new
        game.random_colours
        game.get_player_guess
    end

    def maker_start
        puts "Please choose your code! e.g. 'RGBY' or 'MTBR'. Available colours are: R,G,B,Y,M,T"
        
        # Get user input and remove text, symbols != available colours
        @code = gets.chomp.gsub(/[^RGBYMT]/i, "").strip.upcase 

        # Generate S array, pass to get peg evaluation and feed this to the main game loop
        if @code.length == 4 
            s = @solver.create_s
            evaluation = @solver.get_evaluation(@code, @first_guess)
            puts "Guess #{@round}. #{@first_guess}" + "  " +evaluation
            maker_loop(@solver.prune_s(@first_guess, s))
        else
            (puts "Invalid code")
        end
    end

    def maker_loop(s)
        unless @round == 12
            @round += 1
            guess = s.sample

            if @code == guess
                puts "Guess #{@round}. #{guess}"
                abort "\n \e[31mI guessed it in #{@round} tries!\e[0m \n "

            else 
                evaluation = @solver.get_evaluation(@code, guess)
                puts "Guess #{@round}. #{guess}" + "  " +evaluation
                maker_loop(@solver.prune_s(guess, s))
            end
        end
    end
end

gameloop = GameLoops.new
gameloop.game_mode