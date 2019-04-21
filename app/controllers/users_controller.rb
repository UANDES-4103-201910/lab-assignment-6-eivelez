class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :is_user_logged_in?

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    user=User.new(user_params)
    if user.save
      flash[:notice]="new user was created"
      redirect_to "/users"
    else
      flash[:notice]="new user creation ERROR, please try again"
			redirect_to "/users"
    end
	end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
	def update
		user=User.find(params[:id])
		if user.update(user_params)
			flash[:notice]="Update was completed"
			redirect_to "/users"
		else
			flash[:notice]="Update action failed"
			redirect_to "/users/"+params[:id].to_s+"/edit"
		end
	end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
		if $user.id.to_i==params[:id].to_i
		  User.destroy(params[:id])
			$user=nil
			$helper=false
			is_user_logged_in?
			flash[:notice]="You deleted your own account"
		else
			User.destroy(params[:id])
			redirect_to "/users"
			is_user_logged_in?
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :last_name, :email, :password, :phone)
    end
end
