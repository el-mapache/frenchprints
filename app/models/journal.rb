class Journal < ActiveRecord::Base
  attr_accessible :publication_run, :title

  has_many :locations, through: :personnel_locations
  has_many :people, through: :personnel_locations

  validates :title, presence: true
end
