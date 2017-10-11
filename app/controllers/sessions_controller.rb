class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      login(@user)
      redirect_to root_path
    else
      render new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
