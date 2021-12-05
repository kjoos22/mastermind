Rails.application.routes.draw do
    resources :players, only: [:create, :index]

end
