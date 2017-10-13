class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.fetch_friends(user)
    friendships = Friendship.accepted_friendships(user)
    friendships.map { |friendship| friendship.friend }
  end

  def self.accepted_friendships(user)
    user.friendships.select do |friendship|
      another_friendship = Friendship.find_by(user_id: friendship.friend_id, friend_id: friendship.user_id)
      friendship.accepted && another_friendship.accepted
    end
  end
end
