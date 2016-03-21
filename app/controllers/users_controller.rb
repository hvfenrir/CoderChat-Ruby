class UsersController < ApplicationController
  
  def index
    @users = User.all_friends_except(current_user)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create user_params

  	if @user.persisted?
  		flash[:success] = "Created Successfully !!!"
      session[:user_id] = @user.id
  		redirect_to root_path
  	else
  		flash.now[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
  		render "new"
  	end
  end

  def show
    @user = current_user
  end

  private
  	def user_params
  		params.require(:user).permit(:name , :email, :password, :password_confirmation)
  	end
     def set_user
      @user = User.find(params[:id])
    end
end
