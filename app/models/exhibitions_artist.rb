class ExhibitionsArtist < ActiveRecord::Base
  attr_accessible :person_id, :exhibition_id

  belongs_to :artist, class_name: "Person", foreign_key: :person_id
  belongs_to :exhibition

  validates :person_id, :exhibition_id, presence: true
end
