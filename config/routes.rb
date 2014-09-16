Rails.application.routes.draw do
	get 'users/login'	
	get 'users/logout'
	post 'users/authenticate'
	root 'donors#index'
	
	resources :donors
end
