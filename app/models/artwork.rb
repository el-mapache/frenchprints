class Artwork < ActiveRecord::Base
  attr_accessible :artist_id, :dimensions, :medium, :release_date, :title

  belongs_to :artist, class_name: "Person", foreign_key: :artist_id

  has_media

  validates :title, :medium, :release_date, :artist_id, presence: true
  validates :artist_id, numericality: true
end
