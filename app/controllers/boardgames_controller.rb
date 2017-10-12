class BoardgamesController < ApplicationController

  def index
    @user = User.find_by(id: params[:user_id])
    current_users_games = @user.boardgames
    if params[:search]
     @friends_games = Boardgame.search(params[:search]).order("created_at DESC") - current_users_games
   else
     @current_users_games = current_users_games
     @friends_games = Boardgame.all.order('created_at DESC') - current_users_games
   end
  end

  def new
    @boardgame = Boardgame.new
  end

  def create
    @boardgame = Boardgame.new(boardgame_params)
    @boardgame.image = Boardgame.upload_to_s3(params[:boardgame][:image].tempfile)

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
    @boardgame = Boardgame.find(params[:id])
    @boardgame.destroy

    redirect_to root_path
  end

  private

  def boardgame_params
    params.require(:boardgame).permit(:name, :description, :genre, :players, :image, :owner_id)
  end

end
