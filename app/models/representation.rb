# Model represents a join between two person models, generally a dealer and an artist.
class Representation < ActiveRecord::Base
  attr_accessible :current, :end_date, :represented_id, :representative, :start_date
  
  # Associations 
  belongs_to :representee, class_name: "Person", foreign_key: :represented_id
  belongs_to :representative, class_name: "Person", foreign_key: :person_id

  # Validations
  validates :represented_id, presence: true
  validates :representative, presence: true

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :dates

  validates_uniqueness_of :represented_id, scope: [:person_id, :start_date, :end_date]
  
  # Scopes
  default_scope includes(:representee, :representative)


  private

  def dates
    if end_date && start_date
      errors.add(:start_date, " must be before end date.") unless start_date < end_date
    end
  end
end
