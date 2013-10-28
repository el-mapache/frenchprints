class Journal < ActiveRecord::Base
  attr_accessible :publication_run, :title,
                  :personnel_histories_attributes

  has_many :locations, as: :locatable, dependent: :destroy
  accepts_nested_attributes_for :locations

  has_many :personnel_histories, as: :trackable, dependent: :destroy
  accepts_nested_attributes_for :personnel_histories

  validates :title, presence: true

  class << self
    def all_with_attribute(attr)
      Journal.select(attr).all.map { |j| j[attr] }
    end

    def with_personnel_record(j_id, id) 
      Journal.joins(:personnel_histories).where("personnel_histories.trackable_id = ? AND personnel_histories.id = ?", j_id, id)
    end
  end
end
