class BoardgamesController < ApplicationController

  def index
    if logged_in?
      @user = User.find_by(id: params[:user_id])
      @friend_requests = @user.friendships.where(accepted: false)
      # method to check if two friendship objects match
      @friendships = @user.friendships.select do |friendship|
        another_friendship = Friendship.find_by(user_id: friendship.friend_id, friend_id: friendship.user_id)
        friendship.accepted && another_friendship.accepted
      end

      # search method
      if params[:search]
        @friends_games = Boardgame.search(params[:search]).where.not(owner_id: @user.id).order('created_at DESC')
      else
        @friends_games = Boardgame.where.not(owner_id: @user.id).order('created_at DESC')
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
    if !@boardgame.image.include?("Http")
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
      flash[:notice] = "#{@boardgame} was successfully updated"
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
