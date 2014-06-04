class Medium < ActiveRecord::Base
  attr_accessible :image

#  mount_uploader :image, ImageUploader

  belongs_to :imagable, polymorphic: true
end
