class Game
    attr_accessor :round, :code, :guesses, :feedback

    def initialize
        @round = 1
        @code = Random.random_integer
        @guesses = {}
        @feedback = {}
    end

    def check_guess(guess)
        if guess == "G"
            previous_guesses()
            Mastermind.play_game
        else
            validate_guess(guess)
        end
        if guess == @code.join
            puts "YOU WIN!"
        else
            #get_feedback(guess)
            @guesses[@round] = guess
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
            Mastermind.talk("Guesses must be 4 digits, 0-7, try again.")
            Mastermind.play_game
        end
        guess.split("").each do |num|
            if num.to_i > 7
                Mastermind.talk("Guesses must be 4 digits, 0-7, try again.")
                Mastermind.play_game
            end
        end
    end

    def numeric?(guess)
        Float(guess) != nil rescue false
    end

    def previous_guesses
        if @guesses == {}
            Mastermind.talk("No previous guesses.")
        end
        @guesses.each do |guess|
            Mastermind.talk("Round #{guess[0]}: #{guess[1]}")
        end
        puts ""        
    end

    def get_feedback(guess)
        correct_digits = 0
        correctly_located_digits = 0
        guess.split("").each_with_index do |num, index|
            binding.pry
        end
    end


end