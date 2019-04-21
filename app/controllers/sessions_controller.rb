class SessionsController < ApplicationController
	def new
	end

	def create
		$user = User.find_by(email: session_params[:email], password: session_params[:password])
		if $user
			flash.discard[:notice] = "Welcome "+$user.name+" "+$user.last_name
			$helper=true
			redirect_to "/users"
		else
			flash[:notice] = 'Failed to login, wrong mail, password or both'
			redirect_to root_path
		end

	end

	def destroy
		$user=nil
		$helper=false
		redirect_to root_path
	end


	def session_params
		params.require(:session).permit(:email, :password)
	end
end
