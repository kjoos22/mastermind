# @guesses = {player1 => {}, player2 => {}}
# @feedback = {player1 => {}, player2 => {}}
# @current_turn = 1




class Game
    attr_accessor :round, :code, :guesses, :feedback, :difficulty, :current_turn

    @@num_rounds = {1 => 8, 2 => 10, 3 => 12}
    @@num_digits = {1 => 3, 2 => 4, 3 => 5}

    def initialize(difficulty)
        @difficulty = difficulty
        @round = 1
        @code = Random.random_integer(difficulty)
        @guesses = {1 => {}, 2 => {}}
        @feedback = {1 => {}, 2 => {}}
        @current_turn = 1
    end

    def play_game
        while @round <= Game.num_rounds[@difficulty]
            Mastermind.talk("Round #{@round} of"\
                " #{Game.num_rounds[@difficulty]}!\n")
            Mastermind.talk("Player 1 enter a guess, or G to review your guesses: ",
                     false)
            check_guess(Mastermind.get_input)
            if @current_turn == 0
                break
            end
            @current_turn = 2
            Mastermind.talk("Round #{@round} of"\
                " #{Game.num_rounds[@difficulty]}!\n")
            Mastermind.talk("Player 2 enter a guess, or G to review your guesses: ",
                     false)
            check_guess(Mastermind.get_input)
            @current_turn = 1
            @round += 1            
        end
        if @current_turn != 0        
            Mastermind.talk("GAME OVER!")
            Mastermind.talk("The code was: #{@code.join}")
            Mastermind.talk("Would you like to play again?")
        end
    end

    def check_guess(guess)
        #Determine if player guess is correct
        # if guess == "G"
        #     previous_guesses()
        #     Mastermind.play_game
        # else
        validate_guess(guess)
        # end
        @guesses[@current_turn][@round] = guess
        if guess == @code.join
            Mastermind.talk("CONGRATULATIONS PLAYER#{current_turn}, YOU WIN!")
            if $player
                points = (@@num_rounds[@difficulty] - (@round-1)) * @difficulty
                $player.update_stats(points)
                Mastermind.talk("#{$player.name}, you earned #{points} points!")
            end            
            Mastermind.talk("Would you like to play again?")
            @round = @@num_rounds[@difficulty] + 1
            @current_turn = 0
        else
            get_feedback(guess)
            provide_feedback()
        end
    end

    def validate_guess(guess)
        #Determine if player guess is valid (number, correct # of digits 0-7)
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
        #Display previous guesses from current game with feedback
        if @guesses[current_turn] == {}
            Mastermind.talk("No previous guesses.")
        end
        @guesses[current_turn].each do |guess|
            Mastermind.talk("Round #{guess[0]}: #{guess[1]} | ", false)
            Mastermind.talk(
                "Correct digits: #{@feedback[current_turn][guess[0]][:correct_digits]}",false)
            Mastermind.talk(
                " | Correctly located digits: "\
                "#{@feedback[current_turn][guess[0]][:correct_locations]}") 
        end
        puts ""        
    end

    def get_feedback(guess)
        #Generate feedback for player guess
        correct_digits = 0
        correct_locations = 0
        total_digits = {}
        # @code.each do |num|
        #     total_digits[num] += 1
        # end

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
        @feedback[current_turn][@round] = {correct_digits: correct_digits,
                    correct_locations: correct_locations}
        
    end

    def location_feedback(guess, correct_locations, total_digits)
        #Generate feedback for correctly located digits
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
        #generate feedback for incorrectly located digits
        guess.split("").each do |num|
            if @code.include?(num) && total_digits[num] > 0
                correct_digits += 1
                total_digits[num] -= 1
            end
        end
        return correct_digits, total_digits
    end

    def provide_feedback
        #display feedback to user or end game
        
        Mastermind.talk("You guessed: #{@guesses[current_turn][@round - 1]}")
        Mastermind.talk(
            "Correct digits: #{@feedback[current_turn][@round - 1][:correct_digits]}")
        Mastermind.talk(
            "Correctly located digits: " +
            "#{@feedback[current_turn][@round - 1][:correct_locations]}\n")
    end

    def self.num_rounds
        @@num_rounds
    end

end