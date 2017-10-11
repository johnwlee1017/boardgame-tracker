class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      login(@user)
      redirect_to user_boardgames_path(@user.id)
    else
      render new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
