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
            feedback = get_feedback(guess)
            @feedback[@round] = feedback
            Mastermind.talk("Correct digits: #{@feedback[@round][:correct_digits]}")
            Mastermind.talk("Correct digits in correct locations: #{@feedback[@round][:correct_locations]}")            
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
        correct_locations = 0
        total_digits = {}
        guess.split("").each do |num|
            total_digits[num] = @code.count(num)
        end
        guess.split("").each_with_index do |num, index|
            
            if @code.index(num) == nil
                next
            else
                if @code.each_index.select{|index| @code[index] == num}.include? index
                    if total_digits[num] > 0
                        correct_locations += 1
                        total_digits[num] -= 1
                    end
                # elsif total_digits[num] > 0
                #         correct_digits += 1
                #         total_digits[num] -= 1
                end
            end
        end
        guess.split("").each do |num|
            binding.pry
            if @code.include?(num) && total_digits[num] > 0
                correct_digits += 1
                total_digits[num] -= 1
            end
        end


        feedback = {correct_digits: correct_digits,
                    correct_locations: correct_locations}
    end


end