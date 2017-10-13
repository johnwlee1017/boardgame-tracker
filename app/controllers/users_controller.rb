class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:notice] = "Welecome #{@user.username}!"
      redirect_to user_boardgames_path(@user.id)
    else
      @errors = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
      @user = User.find(params[:id])
      if logged_in?
        redirect_to @user
      else
        redirect_to root_path
      end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
