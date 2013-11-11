class ArticleService
  attr_accessor :article

  def initialize(article)
    @article = article
  end

  def create_or_update(params)
    journal = Journal.where(params[:journal]).first_or_initialize
    person = Person.where(params[:person]).first_or_initialize

    article_params = params[:article].merge!({journal: journal})
    create_subject(params[:article][:subjects_attributes]) if params[:article][:subjects_attributes]

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

  # Normalize the subjects field for our association
  def create_subject(subject_hash)
    subject_hash.each do |key, subject|
      subject["subjectable_type"].singularize.capitalize
    end
  end
end
