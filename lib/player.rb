class Player
    attr_accessor :name, :mm_points, :wins

    def initialize(name, wins, mm_points)
        @name = name
        @wins = wins
        @mm_points = mm_points
    end

    def self.sign_up
        Mastermind.talk("Enter player name: ", false)
        name = Mastermind.get_input
        Mastermind.talk("Enter password: ", false)
        password = Mastermind.get_input
        GameAPI.create_player(name, password)
        Mastermind.player_menu
    end

    def self.sign_in
        Mastermind.talk("Enter player name: ", false)
        name = Mastermind.get_input
        Mastermind.talk("Enter password: ", false)
        password = Mastermind.get_input
        GameAPI.login(name, password)
        Mastermind.player_menu
    end

    def self.sign_out
        Mastermind.talk("Goodbye, #{$player.name}!\n")
        $player = nil
        Mastermind.player_menu
    end

    def stats
        Mastermind.talk("#{$player.name}, you have "\
                        "won #{$player.wins} games, "\
                        "earning #{$player.mm_points} Mastermind points!\n")
        Mastermind.player_menu
    end

    def update_stats(points)
        $player.wins += 1
        $player.mm_points += points
        GameAPI.update_player_stats
    end
end
