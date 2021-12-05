class PlayersController < ApplicationController
    def create
        player = Player.new(player_params)
        player.mm_points = 0
        player.wins = 0
        if player.save            
            render json: PlayerSerializer.new(player)
        else
            render json: {error: "Failed to save"}
        end
    end

    def index
        players = Player.all
        render json: PlayerSerializer.new(players)
    end

    private
    def player_params
        params.require(:player).permit(:name, :password)
    end
end
