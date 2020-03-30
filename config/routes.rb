Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        post "follow", to: "relationships#create"
        delete "unfollow", to: "relationships#destroy"
        resource :start_sleeps, only: :create
        resource :stop_sleeps, only: :create
      end
    end
  end
end
