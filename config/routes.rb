Rails.application.routes.draw do

  resources :products do
    patch :decrement_and_show_message, on: :member
    patch :decrement_as_admin, on: :member
    patch :add_quantity, on: :member
    patch :give, on: :member
    patch :destroy_borrowed, on: :member
  end

  get "rental/successful", to: "rental#successful"
  post 'password/check', to: 'products#check_password'

  resources :rental, only:[:index, :show, :successful]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "rental#index"
end
