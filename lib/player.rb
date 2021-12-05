class Player
    attr_accessor :name, :mm_points, :wins

    def initialize

    end

    def self.sign_up
        puts "Enter player name: "
        name = Mastermind.get_input
        puts "Enter password: "
        password = Mastermind.get_input
        GameAPI.create_player(name, password)
    end
end
