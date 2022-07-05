require_relative 'evaluation.rb'
include EvaluateMatches

module SolverModule   
    class Solver
        def initialize
            @response = ""
        end

        # Generate array with every combination of colours

        def create_s
            colours = ["R", "G", "B", "Y", "M", "T"]
            s = colours.product(*[colours] * 3).map(&:join)
            return s
        end

        # Evaluate the matches from the guess

        def get_evaluation(code, guess)
            @response = Evaluate.new.evaluate_matches(code, guess)
        end

        # Prune any elements of s that would not have produced the same evaluation if they were the secret code

        def prune_s(guess, s)
            s.delete(guess)
            s.delete_if { |x| Evaluate.new.evaluate_matches(x, guess) != @response }
            return s
        end
    end
end
