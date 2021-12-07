class GameAPI
    def self.show_players
        uri = URI("http://127.0.0.1:3000/players")
        response = JSON.parse(Net::HTTP.get(uri))
        response["data"]
    end

    def self.create_player(name, password)
        uri = URI("http://127.0.0.1:3000/players")
        req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
        req.body = {"player" =>{"name" => name, "password" => password}}.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
        end
        if JSON.parse(res.body)["error"]
            Mastermind.talk("Error: name taken or invalid password.\n")
            Mastermind.player_menu
        else
            Mastermind.talk("Player created.")
            $player = Player.new(name, 0, 0)
            Mastermind.main_menu
        end
    end

    def self.login(name, password)
        uri = URI("http://127.0.0.1:3000/players/login")
        req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
        req.body = {"name" => name, "password" => password}.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
        end
        res = JSON.parse(res.body)
        if res["response"] == "Logged in"
            name = res["player"]["name"]
            wins = res["player"]["wins"]
            mm_points = res["player"]["mm_points"]
            $player = Player.new(name, wins, mm_points)
            Mastermind.talk("Welcome back, #{name}!\n")
            Mastermind.player_menu
        elsif res["response"] == "Incorrect password."
            Mastermind.talk("Incorrect password")
        elsif res["response"] == "Player not found."
            Mastermind.talk("Player not found")
        end
    end

    def self.update_player_stats
        uri = URI("http://127.0.0.1:3000/players/update_stats")
        req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
        req.body = {"name" => "#{$player.name}",
                                 "mm_points" => $player.mm_points}.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
        end
    end

end