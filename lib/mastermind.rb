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
            Mastermind.talk("\nThank you for playing with me! Come back soon!")
            puts ""
            exit
        end
        input
    end

    def self.main_menu
        puts "\n---Main Menu---"
        puts "1. Play Game\n2. Future Options"
        print "\nEnter 'EXIT' at anytime to quit.\n"
        print "\nEnter an option #: "
        option = Mastermind.get_input
        case option
            when "1"
                @game = Game.new
                Mastermind.play_game
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
        Mastermind.talk("This is round #{@game.round} of 10!\n")
        Mastermind.talk("Enter a guess, or G to review your guesses: ", false)
        @game.check_guess(Mastermind.get_input)
    end


end


