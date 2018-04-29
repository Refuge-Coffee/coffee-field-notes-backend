Rails.application.routes.draw do
  resources :roasters
  namespace :api do
    namespace :v1 do
      resources :locations
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      jsonapi_resources :beans
      jsonapi_resources :notes
    end
  end
end
