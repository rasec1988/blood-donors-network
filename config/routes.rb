Rails.application.routes.draw do
	get 'users/login'	
	get 'users/logout'
	get 'users/fblogin'
	post 'users/authenticate'
	root 'donors#index'
	
	resources :donors
end
