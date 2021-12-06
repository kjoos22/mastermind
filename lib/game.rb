class Game
    attr_accessor :round, :code, :guesses, :feedback, :difficulty

    @@num_rounds = {1 => 8, 2 => 10, 3 => 12}
    @@num_digits = {1 => 3, 2 => 4, 3 => 5}

    def initialize(difficulty)
        @difficulty = difficulty
        @round = 1
        @code = Random.random_integer(difficulty)
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
        @guesses[@round] = guess
        if guess == @code.join
            if $player
                $player.update_stats(@difficulty, @round)
            end
            Mastermind.talk("CONGRATULATIONS, YOU WIN!")
            Mastermind.talk("Would you like to play again?")
            Mastermind.main_menu
        else
            get_feedback(guess)
            provide_feedback()
        end
        Mastermind.play_game
    end

    def validate_guess(guess)
        if guess.length != @@num_digits[@difficulty] || !numeric?(guess)
            Mastermind.talk("Guesses must be #{@@num_digits[@difficulty]}"\
                " digits, 0-7, try again.")
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
            Mastermind.talk("Round #{guess[0]}: #{guess[1]} | ", false)
            Mastermind.talk(
                "Correct digits: #{@feedback[guess[0]][:correct_digits]}",false)
            Mastermind.talk(
                " | Correctly located digits: "\
                "#{@feedback[guess[0]][:correct_locations]}") 
        end
        puts ""        
    end

    def get_feedback(guess)
        correct_digits = 0
        correct_locations = 0
        total_digits = {}
        guess.split("").each do |num|
            total_digits[num] = @code.count(num)
            if total_digits[num] > guess.count(num)
                total_digits[num] = guess.count(num)
            end
        end
        correct_locations, total_digits = 
            location_feedback(guess, correct_locations, total_digits)
        correct_digits, total_digits = 
            digit_feedback(guess, correct_digits, total_digits)
        @feedback[@round] = {correct_digits: correct_digits,
                    correct_locations: correct_locations}
        @round += 1
    end

    def location_feedback(guess, correct_locations, total_digits)
        guess.split("").each_with_index do |num, index|            
            if @code.index(num) == nil
                next
            end
            if @code.each_index.select{|index| @code[index]==num}.include? index
                if total_digits[num] > 0                       
                    correct_locations += 1
                    total_digits[num] -= 1
                end
            end
        end
        return correct_locations, total_digits
    end

    def digit_feedback(guess, correct_digits, total_digits)
        guess.split("").each do |num|
            if @code.include?(num) && total_digits[num] > 0
                correct_digits += 1
                total_digits[num] -= 1
            end
        end
        return correct_digits, total_digits
    end

    def provide_feedback
        if @round > @@num_rounds[@difficulty]
            Mastermind.talk("GAME OVER!")
            Mastermind.talk("The code was: #{@code.join}")
            Mastermind.talk("Would you like to play again?")
            Mastermind.main_menu
        end
        Mastermind.talk("You guessed: #{@guesses[@round - 1]}")
        Mastermind.talk(
            "Correct digits: #{@feedback[@round - 1][:correct_digits]}")
        Mastermind.talk(
            "Correctly located digits: " +
            "#{@feedback[@round - 1][:correct_locations]}\n")
    end

    def self.num_rounds
        @@num_rounds
    end

end