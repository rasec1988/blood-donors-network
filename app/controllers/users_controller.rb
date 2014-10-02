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
  
  def fblogin
  	fb_user = FbUser.find_by fb_id: params[:fb_id]
  	
  	if fb_user
  		if fb_user.user_id
  			donor = Donor.find_by user_id: fb_user.user_id
  			#render :text => YAML::dump(donor)
  			session[:donor_id] = donor.id
				session[:user_id] = fb_user.user_id
  			redirect_to donors_path
  		else
  			redirect_to new_donor_path(:fb_id => params[:fb_id], :name => params[:name])
			end
  	else
			fb_user = FbUser.new(:fb_id => params[:fb_id])
  		redirect_to new_donor_path(:fb_id => params[:fb_id], :name => params[:name])
  	end
  end
  
  def logout
		reset_session
		redirect_to users_login_path
  end
end
