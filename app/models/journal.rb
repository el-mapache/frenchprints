class Journal < ActiveRecord::Base
  attr_accessible :publication_run, :title

  has_many :locations, as: :locatable, dependent: :destroy
  has_many :personnel_histories, as: :trackable, dependent: :destroy

  validates :title, presence: true
end
