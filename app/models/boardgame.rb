class Boardgame < ApplicationRecord
  belongs_to :owner, class_name: "User"

  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    # where("name iLIKE ?", "%#{search}%") 
    where('name iLIKE :search OR genre iLIKE :search', search: "%#{search}%")
  end
end
