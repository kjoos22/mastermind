Rails.application.routes.draw do
    post '/players/login', to: "players#login"

    resources :players, only: [:create, :index]

end
