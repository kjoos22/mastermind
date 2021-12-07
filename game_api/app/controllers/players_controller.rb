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
        #all players, ordered by MM points
        players = Player.all.order(mm_points: :desc)
        render json: PlayerSerializer.new(players)
    end

    def login
        #retrieve and return player
        player = Player.find_by(name: params[:name])
        if player && player.authenticate(params[:password])
            render json: {response: "Logged in", player: 
                {name: player.name, mm_points: player.mm_points, wins: player.wins}}
        elsif player && !player.authenticate(params[:password])
            render json: {response: "Incorrect password"}
        else
            render json: {response: "Player not found"}
        end
    end

    def update_stats
        player = Player.find_by(name: params[:name])
        player.mm_points = params[:mm_points]
        player.wins += 1
        if player.save
            render json: {response: "Stats updated"}
        else
            render json: {response: "Failed to update"}
        end
    end

    private
    def player_params
        params.require(:player).permit(:name, :password)
    end
end
