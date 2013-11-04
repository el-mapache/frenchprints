class Admin::ArticlesController < Admin::CrudController
  skip_before_filter :get_all

  def index
    @articles = Article.select("people.*, journals.*").includes(:authors, :journal)
    respond_to do |f|
      f.html
      f.json { {articles: @articles} }
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
