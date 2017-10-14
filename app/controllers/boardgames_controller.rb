class BoardgamesController < ApplicationController

  def index
    @all_usernames = User.all.pluck(:username)
    if logged_in?
      @user = User.find_by(id: params[:user_id])
      @friend_requests = @user.friendships.where(accepted: false)
      @friends = Friendship.fetch_friends(@user)

      # search method
      if params[:search]
        @search_results = Boardgame.search(params[:search])
        # @friends_games = Boardgame.search(params[:search]).where.not(owner_id: @user.id).order('created_at DESC')
      else
        @friends_games = Boardgame.friends_games(@friends)
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
    if params[:boardgame][:image]
      @boardgame.image = Boardgame.upload_to_s3(params[:boardgame][:image].tempfile)
    end

    if @boardgame.save
      flash[:notice] = "#{@boardgame.name} was successfully saved"
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
      if session[:user_id] != @boardgame.owner_id
        flash[:alert] = "Can't edit another user game"
        redirect_to user_boardgames_path(@boardgame.owner_id)
      end
    else
      redirect_to root_path
    end
  end

  def update
    @boardgame = Boardgame.find_by(id: params[:id])
    @boardgame.image = params[:boardgame][:image]
    if @boardgame.image.include?("Http")
      @boardgame.image = Boardgame.upload_to_s3(params[:boardgame][:image].tempfile)
    end

    if @boardgame.update(boardgame_params)
      flash[:notice] = "#{@boardgame.name} was successfully updated"
      redirect_to user_boardgames_path(@boardgame.owner_id)
    else
      @errors = @boardgame.errors.full_messages
      render :edit
    end
  end

  def destroy
    @boardgame = Boardgame.find(params[:id])
    @boardgame.destroy
    flash[:notice] = "#{@boardgame} was successfully deleted"
    redirect_to user_boardgames_path
  end

  private

  def boardgame_params
    params.require(:boardgame).permit(:name, :description, :genre,:play_time, :players, :owner_id)
  end

end
