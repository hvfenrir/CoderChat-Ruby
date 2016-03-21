module SessionsHelper

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def user_logged_in
    unless logged_in?
      flash[:error] = "You must log in if you want to go this page"
      redirect_to new_session_path
    end
  end
end
