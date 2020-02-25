Rails.application.routes.draw do
  scope module: 'api' do

    namespace :v1 do
      get 'movies/index'
      get 'movies/show'

    end

  end
end
