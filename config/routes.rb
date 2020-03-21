Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :users, module: :users, only: %i[create]
      
    end
  end
end
