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

    def self.leaderboard
        players = GameAPI.show_players
        Mastermind.talk("---Top 5 Players---")
        x = 1
        players = players[0..4]
        players.each do |player|
            Mastermind.talk("#{x}. #{player["attributes"]["name"]} - "\
                "#{player["attributes"]["mm_points"]} points.")
            x += 1
        end
        puts ""
        Mastermind.player_menu
    end

    def stats
        Mastermind.talk("#{$player.name},") 
        Mastermind.talk("You have won #{$player.wins} games!")
        Mastermind.talk("You have earned #{$player.mm_points} Mastermind points!")
        Mastermind.talk("Your rank is #{$player.get_rank}!\n")
        Mastermind.player_menu
    end

    def update_stats(points)
        $player.wins += 1
        $player.mm_points += points
        GameAPI.update_player_stats
    end

    def get_rank
        case $player.mm_points
            when 0..9
                "Feeblemind"
            when 10..49
                "Averagemind"
            when 50..99
                "Strongmind"
            else
                "Mastermind"
        end
    end
end
