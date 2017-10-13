class FriendshipsController < ApplicationController
  def new
  end

  def create
    friend_id = params[:friendships][:friend_id]
    # add validation if already friends
    Friendship.create(friend_id: friend_id, user_id: current_user.id, accepted: true)
    Friendship.create(friend_id: current_user.id, user_id: friend_id)
    flash[:notice] = "Friend request sent"
    redirect_to user_boardgames_path(friend_id)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(accepted: true)
    flash[:notice] = "You became #{@friendship.friend.username}'s friend"
    redirect_to user_boardgames_path(current_user.id)
  end

end
