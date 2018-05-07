Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      jsonapi_resources :beans
      jsonapi_resources :notes
      jsonapi_resources :locations
      jsonapi_resources :roasters
    end
  end
end
