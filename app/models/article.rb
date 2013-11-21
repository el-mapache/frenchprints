class Article < ActiveRecord::Base
  attr_accessible :date_published, :journal, :pages, :title,
                  :authors_articles_attributes, :issue_number,
                  :subjects_attributes

  # Defines subjects that an article can be written about
  SUBJECTS = ["artworks", "people", "galleries", "articles", "journals"]

  # Currently there is a one to one relationship with a journal,
  # and the issue number appears on the authors_articles join table.
  # This means that it won't be possible to associate an article with new
  # journals (for instance if the work is reprinted). This is supposedly not
  # an issue but I should keep it in mind.
  #
  # Alternate schema has an additional join table between journals and articles,
  # with a has and belongs to many relationship.  The issue number could then
  # live there.
  belongs_to :journal, foreign_key: :journal_id

  has_many :authors_articles
  has_many :authors, through: :authors_articles
  accepts_nested_attributes_for :authors_articles

  has_many :subjects
  accepts_nested_attributes_for :subjects

  validates :date_published, :journal_id, :pages, :title, presence: true

  # class methods
  class << self
    def subjects
      SUBJECTS
    end
  end

  # Instance methods
  # TODO think about moving these into a presenter.
  def author
    return nil if authors.empty?
    authors.first.name
  end

  def published_in
    return nil if journal.nil?
    journal.title
  end
end

