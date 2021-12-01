class Game
    attr_accessor :round, :code, :guesses, :feedback

    def initialize
        @round = 1
        @code = Random.random_integer
        @guesses = {}
        @feedback = {}
    end

    def check_guess(guess)
        validate_guess(guess)
        if guess == @code.join
            puts "YOU WIN!"
        else
            @guesses[:"#{@round}"] = guess
            @round += 1
        end
        if @round > 10
            puts "GAME OVER!"
        else
            Mastermind.play_game
        end
    end

    def validate_guess(guess)
        if guess.length != 4 || !numeric?(guess)
            Mastermind.talk("Invalid guess, try again: ")
            check_guess(Mastermind.get_input)
        end      
    end

    def numeric?(guess)
        Float(guess) != nil rescue false
    end


end