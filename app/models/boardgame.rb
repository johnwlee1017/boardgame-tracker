class Boardgame < ApplicationRecord
  belongs_to :owner, class_name: "User"
  validates :name, :description, :genre, :players, :play_time, presence: true

  def self.search(search)
    # get all usernames
    # from those usernames, make an array of relevant usernames based on search parameter
    all_usernames = Boardgame.first.owner.class.all.pluck(:username)
    username_search_results = []
    all_usernames.each do |user|
      if user.include?(search)
        username_search_results << user
      end
    end


    # get the games from the relevant usernames
    games_by_relevant_usernames = []
    username_search_results.each do |user|
      games_by_relevant_usernames << Boardgame.includes(:owner).where(:users => { username: user } ).all
    end

    games_by_relevant_usernames << where('name iLIKE :search OR genre iLIKE :search', search: "%#{search}%")
    return games_by_relevant_usernames[0]

  end

  def self.upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('board-game-tracker').object(File.basename(image))
    obj.upload_file(image)
    obj.public_url
  end

  def self.friends_games(friends)
    friends_boardgame = []
    return nil if friends.empty?
    friends.each { |friend| friends_boardgame << friend.boardgames }
    friends_boardgame.flatten!
  end
end
