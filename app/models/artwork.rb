class Artwork < ActiveRecord::Base
  attr_accessible :artist_id, :dimensions, :medium, :release_date, :title

  belongs_to :artist, class_name: "Person", foreign_key: :artist_id

  validates :title, presence: true
  validates :medium, presence: true
  validates :release_date, presence: true
  validates :artist_id, presence: true, numericality: true
end
