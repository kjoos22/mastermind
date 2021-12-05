class GameAPI
    def self.show_players
        url = "http://127.0.0.1:3000/players"

        response = JSON.parse(Net::HTTP.get(URI(url)))
        response["data"]
    end

end