class Representation < ActiveRecord::Base
  attr_accessible :current, :end_date, :represented_id, :person_id, :start_date
  
  # Associations
  belongs_to :representee, class_name: "Person", foreign_key: :represented_id
  belongs_to :representative, class_name: "Person", foreign_key: :person_id

  # Validations
  validates :representee, presence: true
  validates :representative, presence: true

  validates :start_date, presence: true
  validates :end_date, presence: true

  validates_uniqueness_of :represented_id, scope: [:person_id, :start_date, :end_date]
  
  # Scopes
  default_scope includes(:representee, :representative)
end
