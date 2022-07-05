require_relative 'evaluation.rb'

include EvaluateMatches





colours = ["R", "G", "B", "Y", "M", "T"]
s = colours.product(*[colours] * 3).map(&:join)

guess = "RRGM"
answer = "RRGY"
@response = ""


def get_evaluation(answer, guess)
    @response = Evaluate.new.evaluate_matches(answer, guess)
end

def prune_s(guess, s, z)
    s.delete_if { |x| Evaluate.new.evaluate_matches(x, guess) != @response }
end



puts get_evaluation(answer, guess)

prune_s(guess, s, 0)
p s.length




#     s.each { |x|
#         evaluation = Evaluate.new.evaluate_matches(x, guess)
#         z += 1
#         if evaluation != @response
#             s.delete(x)
#         end
#     }
# puts z