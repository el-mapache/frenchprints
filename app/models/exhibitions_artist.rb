class ExhibitionsArtist < ActiveRecord::Base
  attr_accessible :artist_id, :exhibition_id

  belongs_to :artist, class_name: :person, foreign_key: :artist_id
  belongs_to :exhibition

  validates :artist_id, :exhibition_id, presence: true
end
