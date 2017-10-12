class BoardgamesController < ApplicationController

  def index
    if logged_in?
      @user = User.find_by(id: params[:user_id])

      if params[:search]
       @friends_games = Boardgame.search(params[:search]).order("created_at DESC")
     else
       @current_users_games = @user.boardgames
       @friends_games = Boardgame.all.order('created_at DESC')
     end
   else
     redirect_to root_path
   end
  end

  def new
    if logged_in?
      @boardgame = Boardgame.new
    else
      redirect_to root_path
    end
  end

  def create
    @boardgame = Boardgame.new(boardgame_params)

    if @boardgame.save
      redirect_to user_boardgames_path(@boardgame.owner_id)
    else
      @errors = @boardgame.errors.full_messages
      render 'new'
    end
  end

  def show
    @boardgame = Boardgame.find_by(id: params[:id])
  end


  def edit

    if logged_in?
      @boardgame = Boardgame.find_by(id: params[:id])
    else
      redirect_to root_path
    end
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
    @boardgame = Boardgame.find(params[:id])
    @boardgame.destroy

    redirect_to user_boardgames_path
  end

  private

  def boardgame_params
    params.require(:boardgame).permit(:name, :description, :genre, :players, :image, :owner_id)
  end

end
