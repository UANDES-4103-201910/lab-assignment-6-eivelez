class RegistrationsController < ApplicationController

	def new
	end

	def create
		@registrations=User.new(parameters)
		if @registrations.save
			redirect_to root_url, notice: "Registration done"
		else
			flash[:error]="There was an error on your request"
			render "new"
		end
	end
	
	def parameters
		params.require(:registrations).permit(:name,:last_name, :email, :password, :phone)
	end

end
