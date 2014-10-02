class UsersController < ApplicationController
  def login
		@error = params[:error] == 'true'
		@active = :login
  end
  
  def authenticate
		p = params[:user]
		user = User.find_by username: p[:username], password: p[:password]
		
		if user
			donor = Donor.find_by user_id: user.id
			session[:donor_id] = donor.id
			session[:user_id] = user.id
			redirect_to donors_path
		else
			redirect_to users_login_path(:error => 'true')
		end
  end
  
  def fbLogin
  	fb_user = FbUser.find_by fb_id: params[:fb_id]
  	
  	if fb_user
  		if fb_user.user_id != 0
  			redirect_to donors_path
  		else
  			redirect_to donors_new_path
			end
  	else
  		redirect_to donors_new_path
  	end
  end
  
  def logout
		reset_session
		redirect_to users_login_path
  end
end
