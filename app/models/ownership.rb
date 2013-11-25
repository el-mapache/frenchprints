class Ownership < ActiveRecord::Base
  attr_accessible :artwork_id, :end_date, :person_id, :start_date

  belongs_to :person
  belongs_to :artwork

  validates :artwork_id, :person_id, :start_date, presence: true

  validates :artwork_id, uniqueness: {
    scope: [:person_id, :start_date],
    message: "A record already exists of this person owning the artwork"
  }
end
