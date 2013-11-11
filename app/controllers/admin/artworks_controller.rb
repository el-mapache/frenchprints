class Admin::ArtworksController < Admin::CrudController
  def index
    respond_to do |f|
      f.json { render json: @artworks }
      f.html { render "index" }
    end
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
