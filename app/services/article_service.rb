class ArticleService
  attr_accessor :article

  def initialize(article)
    @article = article
  end

  def create_or_update(params)
    journal = Journal.where(params[:journal]).first_or_initialize
    person = Person.where(params[:person]).first_or_initialize

    if params[:article][:subjects_attributes]
      subjects = params[:article][:subjects_attributes]
      params[:article].delete(:subjects_attributes)

      article_params = params[:article].merge!({
        journal: journal,
        subjects_attributes: normalize_subject_type(subjects)
      })
    end

    # If the article object getting passed in is a new record,
    # remake it with the form attributes, else, update the existing 
    # record's attributes
    if @article.new_record?
      @article = Article.new(article_params)
    else
      @article.update_attributes(article_params)
    end

    @article.authors_articles.where(person_id: person.id).first_or_create do |aa|
      aa.article_id = @article.id
      aa.person_id = person.id
    end

    # Return the article
    @article
  end

  # this doesnt save the original
  # Normalize the subjects field for our association
  def normalize_subject_type(subject_hash)
    subject_hash.each do |key, subject|
      subject["subjectable_type"] = subject["subjectable_type"].singularize.capitalize!
    end
  end
end
