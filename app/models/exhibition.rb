class Exhibition < ActiveRecord::Base
  attr_accessible :gallery_id, :name, :person_id, :locations_attributes

  has_many :locations, as: :locatable
  accepts_nested_attributes_for :locations

  belongs_to :gallery
  belongs_to :person

  validates :name, presence: true
end
