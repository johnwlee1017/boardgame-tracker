class SessionsController < ApplicationController

  def new
    # find current user by session id
    @user = User.find_by(id: session[:user_id])

    if logged_in?
      redirect_to user_boardgames_path(@user.id)
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
      flash[:notice] = "Welecome back #{@user.username}!"
      redirect_to user_boardgames_path(@user.id)
    else
      @errors = ["Username and/or password is incorrect. Please try again."]
      render :new
    end
  end

  def destroy
    logout
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

end
