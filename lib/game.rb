class Game
    attr_accessor :round, :code, :guesses, :feedback

    def initialize
        @round = 1
        @code = Random.random_integer
        @guesses = {}
        @feedback = {}
    end

    def check_guess(guess)
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

end