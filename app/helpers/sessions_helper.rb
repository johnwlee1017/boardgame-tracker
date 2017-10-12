module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
  end

  def logged_in?
    if session[:user_id] != nil
      true
    else
      false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def page_belongs_to_user?
    return true if @user.id == session[:user_id]
    false
  end

end
