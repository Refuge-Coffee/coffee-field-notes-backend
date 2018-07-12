Rails.application.routes.draw do
  
  # Use for login and autorize all resource
  use_doorkeeper do
    # No need to register client application
    skip_controllers :applications, :authorized_applications
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }, skip: [:sessions, :password]

      jsonapi_resources :beans
      jsonapi_resources :notes
      jsonapi_resources :locations
      jsonapi_resources :roasters
    end
  end
end
