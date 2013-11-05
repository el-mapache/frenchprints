class AuthorsArticle < ActiveRecord::Base
  attr_accessible :article_id, :person_id

  belongs_to :article
  belongs_to :author, class_name: "Person", foreign_key: :person_id

  validates :article_id, :person_id, presence: true
  validates :article_id, uniqueness: {
    scope: [:person_id],
    message: "A record already exists linking this author and article."
  }
end
