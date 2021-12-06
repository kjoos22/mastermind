Rails.application.routes.draw do
    post "/players/login", to: "players#login"
    post "/players/update_stats", to: "players#update_stats"

    resources :players, only: [:create, :index]

end
