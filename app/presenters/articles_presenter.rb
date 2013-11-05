class ArticlesPresenter
  def initialize
    #@articles = Article.select("people.*, journals.*, authors_articles.issue_number").includes(:authors, :journal)
  end

  def build
   {
     article: Article.new
   }.to_json
  end

  def as_hash
    # perform json magic here
  end
end
