class Subject < ActiveRecord::Base
  attr_accessible :article_id, :subjectable_type, :subjectable_id

  belongs_to :subjectable, polymorphic: true
  belongs_to :article

  validates :article_id, :subjectable_type, :subjectable_id, presence: true
  validates :article_id, uniqueness: {
    scope: [:subjectable_type, :subjectable_id]
  }

  def name
    subject_instance = subjectable

    subject_instance.send(subject_instance.respond_to?(:title) ? :title : :name)
  end
end
