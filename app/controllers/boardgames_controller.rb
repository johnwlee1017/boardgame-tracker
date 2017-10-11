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
    @boardgame = Boardgame.find_by(id: params[:id])
  end

  def update
    @boardgame = Boardgame.find_by(id: params[:id])
    if @boardgame.update(boardgame_params)
      redirect_to user_boardgames_path(@boardgame.owner_id)
    else
      render :edit
    end
  end

  def destroy

  end
end
