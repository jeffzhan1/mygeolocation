Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  post 'geolocations' => 'geolocations#create', format: :json
  post 'geolocations/:ip_address' => 'geolocations#create', 
        :constraints => {:ip_address => /(([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)/}, format: :json

  get 'geolocations/:ip_address' => 'geolocations#show', 
        :constraints => {:ip_address => /(([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)/}, format: :json

  delete 'geolocations/:ip_address' => 'geolocations#destroy', 
        :constraints => {:ip_address => /(([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}([1-9]?\d|1\d\d|2[0-5][0-5]|2[0-4]\d)/}, format: :json
end
