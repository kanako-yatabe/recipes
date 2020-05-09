module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def follow_user
    @follow_user = @user.all_following
  end 
  
  def current_user?(user)
    user == current_user
  end
end