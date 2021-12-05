class Mastermind

    def start 
        system("clear")
        Mastermind.talk("Welcome, I am the Mastermind!")
        Mastermind.talk("Have you come to challenge me?")
        Mastermind.main_menu
    end

    def self.get_input
        input = gets.chomp
        system("clear")        
        if input == "EXIT" 
            Mastermind.talk("Thank you for playing with me! Come back soon!")
            puts ""
            exit
        end
        input
    end

    def self.main_menu
        Mastermind.talk("\n---Main Menu---")
        Mastermind.talk("1. Play Game\n2. Learn to Play\n3. Player Menu")
        Mastermind.talk("\nEnter 'EXIT' at anytime to quit.")
        Mastermind.talk("\nEnter an option #: ", false)
        case Mastermind.get_input
            when "1"
                Mastermind.difficulty_menu
            when "2"
                Mastermind.learn_game
            when "3"
                Mastermind.player_menu
            else
                system("clear")
                Mastermind.talk("That is not a valid option, try again.")
                Mastermind.main_menu
        end
    end

    def self.talk(message, linebreak = true)
        for char in message.split("") do
            print char.green.bold
            sleep(0.04)
        end
        if(linebreak == true)
            puts ""
        end
    end

    def self.play_game
        Mastermind.talk("CODE: #{@game.code}")
        Mastermind.talk("Round #{@game.round} of"\
            " #{Game.num_rounds[@game.difficulty]}!\n")
        Mastermind.talk("Enter a guess, or G to review your guesses: ", false)
        @game.check_guess(Mastermind.get_input)
    end

    def self.learn_game
        system("clear")
        Mastermind.talk("Lorem Ipsum")
        Mastermind.main_menu
        ###############################
        # TODO: Add game instructions #
        ###############################
    end

    def self.difficulty_menu
        system("clear")
        Mastermind.talk("---Difficulty Select---")
        Mastermind.talk("1. Easy\n2. Medium\n3. Hard\n")
        Mastermind.talk("Enter a difficulty #: ", false)
        case Mastermind.get_input
            when "1", "2", "3"
                @game = Game.new(difficulty.to_i)
            else
                system("clear")
                Mastermind.talk("That is not a valid difficulty, try again.")
                Mastermind.difficulty_menu
            end
        Mastermind.play_game        
    end

    def self.player_menu
        system("clear")
        Mastermind.talk("---Player Menu---")
        Mastermind.talk("1. Sign Up")
        Mastermind.talk("\nEnter an option #: ", false)
        case Mastermind.get_input
            when "1"
                puts "Enter player name: "
                name = Mastermind.get_input
                puts "Enter password: "
                password = Mastermind.get_input
                GameAPI.sign_up(name, password)
                
                puts GameAPI.show_players
            else
        end
    end

end


