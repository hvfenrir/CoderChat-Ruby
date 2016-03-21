class SessionsController < ApplicationController
  def new
  end

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "Logged Out"
  	redirect_to root_path
  end

  def create
  	if @user = User.find_by(email: params[:email]) and @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to @user, flash: {success: "Logged In"}
  	else
  		flash.now[:error] = "Invlaid username or password"
  		render 'new'
  	end
  end
end
