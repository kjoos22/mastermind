class Mastermind

    def start 
        system("clear")
        Mastermind.talk("Welcome, I am the Mastermind!")
        Mastermind.talk("Have you come to challenge me?")
        Mastermind.main_menu
    end

    def self.get_input 
        input = gets.chomp        
        if input == "EXIT" 
            for char in "\nThank you for playing Mastermind! Come back soon!"
                    .split("") do
                print char
                sleep(0.05)
            end
            puts""
            exit
        end
        input
    end

    def self.main_menu
        puts "\n---Main Menu---"
        puts "1. Play Game\n2. Future Options"
        print "\nSelect an option: "
        option = Mastermind.get_input
    end

    def self.talk(message)
        for char in message.split("") do
            print char.light_green
            sleep(0.05)
        end
        puts ""
    end



end


