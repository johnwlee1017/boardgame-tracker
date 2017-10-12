class Boardgame < ApplicationRecord
  belongs_to :owner, class_name: "User"

  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    where("name LIKE ?", "%#{search}%")
  end

  def self.upload_to_s3(image)
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('board-game-tracker').object(File.basename(image))
    obj.upload_file(image)
    obj.public_url
  end
end
