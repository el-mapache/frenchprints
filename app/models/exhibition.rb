class Exhibition < ActiveRecord::Base
  attr_accessible :description, :gallery_id, :name, :person_id, :locations_attributes

  has_many :locations, as: :locatable
  accepts_nested_attributes_for :locations

  has_many :exhibitions_artists
  has_many :artists, through: :exhibitions_artists, source: :person, foreign_key: :person_id

  has_many :media, as: :imagable

  belongs_to :gallery
  belongs_to :organizer, class_name: "Person", foreign_key: :person_id

  validates :name, presence: true

  def organized_by
    return nil if organizer.nil?
    organizer.name
  end
end
