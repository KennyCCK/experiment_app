Rails.application.routes.draw do

  scope module: 'api' do

    namespace :v1 do
      resources :movies, controller: :movies, param: :id do
        member do
          post :purchase, to: 'movies#purchase'
        end
      end
      resources :seasons, controller: :seasons, param: :id do
        member do
          post :purchase, to: 'seasons#purchase'
        end
      end
      get :browse, to: 'browse#index'
      get :library, to: 'user_libraries#index'
    end

  end
end
