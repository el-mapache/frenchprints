class Admin::ArticlesController < Admin::CrudController
  skip_before_filter :get_all

  def index
    @articles = Article.select("people.*, journals.*").includes(:authors, :journal)
    respond_to do |f|
      f.json { render json: @articles }
      f.html { render "index" }
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
    article_service = ArticleService.new(@article)
    @article = article_service.create_or_update(params)

    respond_to do |f|
      if @article.save
        f.html { redirect_to admin_articles_path, notice: "Record created successfully." }
      else
        f.html { render "new", error: @article.errors.full_messages }
      end
    end
  end

  def update
    @article_service = ArticleService.new(@article)

    respond_to do |f|
      if @article_service.create_or_update(params)
        f.html { redirect_to admin_articles_path, notice: "Record updated successfully." }
      else
        f.html { render "edit", error: @article_service.article.errors.full_messages }
      end
    end
  end

  def destroy
    respond_to do |f|
      if @article.delete
        f.html { redirect_to admin_articles_path, notice: "Record successfully destroyed" }
      else
        f.html { redirect_to :back, error: "Something went wrong." }
      end
    end
  end
end
