class Representation < ActiveRecord::Base
  attr_accessible :current, :end_date, :represented_id, :person_id, :start_date
  
  belongs_to :representee, class_name: "Person", foreign_key: :represented_id
  belongs_to :representative, class_name: "Person", foreign_key: :person_id

  validate :representee, presence: true
  validate :representative, presence: true

  validate :start_date, presence: true
  validate :end_date, presence: true

  validates_uniqueness_of :represented_id, scope: [:person_id, :start_date, :end_date]
  
  default_scope includes(:representee, :representative)
  class << self
  end
end
