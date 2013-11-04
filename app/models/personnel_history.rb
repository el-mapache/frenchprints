class PersonnelHistory < ActiveRecord::Base
  attr_accessible :person_id ,:start_date, :end_date, :location_id

  belongs_to :person
  belongs_to :location

  belongs_to :trackable, polymorphic: true
  
  validates :person_id, :location_id, :start_date, presence: true
  validates :person_id, uniqueness: { 
    scope: [:trackable_id, :location_id, :start_date, :end_date]
  }
  
  default_scope includes(:person)
end
