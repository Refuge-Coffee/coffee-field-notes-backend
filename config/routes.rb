Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      jsonapi_resources :beans do
        jsonapi_resources :notes
      end
      jsonapi_resources :notes do
        jsonapi_resources :beans
      end
    end
  end
end
