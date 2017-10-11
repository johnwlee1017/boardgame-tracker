class BoardgamesController < ApplicationController

  def index
    @user = User.find_by(id: params[:user_id])

    if params[:search]
     @friends_games = Boardgame.search(params[:search]).order("created_at DESC")
   else
     @current_users_games = @user.boardgames
     @friends_games = Boardgame.all.order('created_at DESC')
   end
  end

  def new
  end

  def create

  end

  def show
    @boardgame = Boardgame.find_by(id:params[:id])
  end


  def edit

  end

  def update

  end

  def destroy

  end
end
