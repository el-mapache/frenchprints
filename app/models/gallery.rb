class Gallery < ActiveRecord::Base
  attr_accessible :name, :locations_attributes, :personnel_histories_attributes

  has_many :locations, as: :locatable, dependent: :destroy
  accepts_nested_attributes_for :locations

  has_many :personnel_histories, as: :trackable, dependent: :destroy
  accepts_nested_attributes_for :personnel_histories

  has_many :exhibitions, dependent: :delete_all

  validates :name, presence: true
end
