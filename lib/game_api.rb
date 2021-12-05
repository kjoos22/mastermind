class GameAPI
    def self.show_players
        ##################################
        # TODO: Remove. Test method only #
        ##################################
        url = "http://127.0.0.1:3000/players"

        response = JSON.parse(Net::HTTP.get(URI(url)))
        response["data"]
    end

    def self.create_player(name, password)
        uri = URI("http://127.0.0.1:3000/players")
        req = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
        req.body = {"player" => {"name" => "#{name}", "password" => "#{password}"}}.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
        end
        if JSON.parse(res.body)["error"]
            Mastermind.talk("Error - name taken or invalid password.")
            Mastermind.player_menu
        else
            Mastermind.talk("Player created.")
            Mastermind.main_menu
        end
        

        
    end

end