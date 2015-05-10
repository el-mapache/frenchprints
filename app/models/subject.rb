# This class acts as a join between an article and database objects the article references.
# For example, an article might refer to several works of art, and they can be retreived through
# this class. Currently only articles and artworks can be subjects, however, any class can be made
# 'subjectable.'
#
# This may be better understood as a concern in the future.  If refactoring needs to happen.
# classic dhh post https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns
class Subject < ActiveRecord::Base
  attr_accessible :article_id, :subjectable_type, :subjectable_id

  belongs_to :subjectable, polymorphic: true
  belongs_to :article

  validates :article_id, :subjectable_type, :subjectable_id, presence: true
  validates :article_id, uniqueness: {
    scope: [:subjectable_type, :subjectable_id]
  }

  # This is an adapter to ensure the subjected model instance has a consistent interface for
  # displaying the name of the instance. 
  # TODO will need to expand this to a case statement when additional items are made
  # 'subjectable.'
  def name
    subject_instance = subjectable

    subject_instance.send(subject_instance.respond_to?(:title) ? :title : :name)
  end
end
