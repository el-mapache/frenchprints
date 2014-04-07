class Artwork < ActiveRecord::Base
  attr_accessible :artist_id, :dimensions, :medium, :release_date, :title

  belongs_to :artist, class_name: "Person", foreign_key: :artist_id

  has_media

  has_many :transactions, dependent: :destroy
  has_many :ownerships

  validates :artist_id, :title, :medium, :release_date, presence: true
  validates :artist_id, numericality: true
end
