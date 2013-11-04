class Article < ActiveRecord::Base
  attr_accessible :date_published, :journal_id, :pages, :title, 
                  :authors_articles_attributes

  # Currently there is a one to one relationship with a journal,
  # and the issue number appears on the authors_articles join table.
  # This means that it won't be possible to associate an article with new
  # journals (for instance if the work is reprinted). This is supposedly not
  # an issue but I should keep it in mind.
  #
  # Alternate schema has an additional join table between journals and articles,
  # with a has and belongs to many relationship.  The issue number could then
  # live there.
  belongs_to :journal

  has_many :authors_articles
  has_many :authors, through: :authors_articles
  accepts_nested_attributes_for :authors_articles

  validates :date_published, :journal_id, :pages, :title, presence: true
end
