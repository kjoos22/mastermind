##Potential GUI component

# require "gosu"

# class Mastermind < Gosu::Window
#     def initialize
#         super 640, 480
#         self.caption = "Mastermind"
#         @font = Gosu::Font.new(20)
#     end

#     def update
        
#     end

#     def draw
#         #render new random code
#         #@font.draw_text(Random.random_integer, 10, 10, 1, 1.0, 1.0)
#     end

# end

class Mastermind

    def start
        system("clear")
        puts "Welcome to Mastermind!"
        Mastermind.get_input
    end

    def self.get_input
        input = gets.chomp
        if input == "EXIT"
            puts "\nThank you for playing Mastermind! Come back soon!"
            exit
        end
        input
    end


end


