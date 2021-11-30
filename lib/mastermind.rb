require "gosu"

class Mastermind < Gosu::Window
    def initialize
        super 640, 480
        self.caption = "Mastermind"
        @font = Gosu::Font.new(20)
    end

    def update
        
    end

    def draw
        @font.draw_text(RandomAPI.random_integer, 10, 10, 1, 1.0, 1.0)
    end

end
