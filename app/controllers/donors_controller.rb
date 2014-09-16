class DonorsController < ApplicationController
	def index
		search = params[:search]
		@blood_types = ['All', 'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
		
		if search
			if search[:blood_type] == 'All'
				@blood_type = 'All'
				@donors = Donor.all
			else
				@blood_type = search[:blood_type]
				@donors = Donor.where(blood_type: search[:blood_type]).take(50)
			end
		else
			@donors = Donor.all
		end
	end

	def new		
		@active = :register
	end
	
	def create
		user = User.new(user_params)
		user.save
		
		donor = donor_params.clone
		donor[:user_id] = user.id
	
		@donor = Donor.new(donor)

		@donor.save
		redirect_to donors_path
	end
	
	def show
		@donor = Donor.find(params[:id])
	end
	
	def edit		
		@donor = Donor.find(params[:id])
		@active = :profile
		
		if @donor.user_id != session[:user_id]
			redirect_to donors_path
		end
	end
	
	def update
		@donor = Donor.find(params[:id])
		
		if @donor.user_id == session[:user_id]		
			if @donor.update(donor_params)
				redirect_to @donor
			else
				render 'edit'
			end
		else
			redirect_to donors_path
		end
	end
	
	def destroy
		if session[:user_id] == 1	
			@donor = Donor.find(params[:id])
			@donor.destroy
		end
		
		redirect_to donors_path
	end
	
	private
		def donor_params
			params.require(:donor).permit(:name, :blood_type, :location, :contact_info, :occupation, :last_donated, :notes)
		end
		
		def user_params
			params.require(:donor).permit(:username, :password)
		end
end
