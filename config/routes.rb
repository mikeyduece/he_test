Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :users, module: :users, only: %i[create]
      
      scope module: :search do
        resources :breweries, module: :breweries, only: %i[index show]
      end
    end
  end
end
