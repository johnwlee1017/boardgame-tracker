class Boardgame < ApplicationRecord
  belongs_to :owner, class_name: "User"
  validates :name, :description, :genre, :players, :play_time, presence: true

  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    # where("name iLIKE ?", "%#{search}%")
    where('name iLIKE :search OR genre iLIKE :search', search: "%#{search}%")
  end

  def self.upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('board-game-tracker').object(File.basename(image))
    obj.upload_file(image)
    obj.public_url
  end

  private

  def check_image

  end
end
