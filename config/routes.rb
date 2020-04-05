Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        post "follow", to: "relationships#create"
        delete "unfollow", to: "relationships#destroy"
        resources :operations, only: [:index, :create]
        resources :following_sleeps, only: :index
      end
    end
  end
end
