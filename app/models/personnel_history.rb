class PersonnelHistory < ActiveRecord::Base
  attr_accessible :person_id ,:start_date, :end_date

  belongs_to :person

  belongs_to :trackable, polymorphic: true
  
  validates :person_id, :start_date, presence: true
  validates :person_id, uniqueness: { 
    scope: [:trackable_id, :start_date, :end_date]
  }
end
