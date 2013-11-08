class Subject < ActiveRecord::Base
  attr_accessible :article_id, :subjectable_type, :subjectable_id

  belongs_to :subjectable, polymorphic: true
  belongs_to :article

  validates :article_id, :subjectable_type, :subjectable_id, presence: true
  validates :article_id, uniqueness: {
    scope: [:subjectable_type, :subjectable_id]
  }

end
