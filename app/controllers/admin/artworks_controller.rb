class Admin::ArtworksController < Admin::CrudController
  skip_before_filter :create

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
    @artwork = Person.find(params[:person_id]).artworks.create(params[:artwork])
    respond_to do |f|
      if @artwork.save
        f.html { redirect_to admin_artworks_path, notice: "Artwork saved successfully." }
      else
        f.html { render "new", error: @artwork.errors.full_messages } 
      end
    end
  end

  def update
  end

  def destroy
    respond_to do |f|
      if @artwork.delete
        f.html { redirect_to admin_artworks_path, notice: "Artwork successfully destroyed" }
      else
        f.html { redirect_to :back, error: "Record not deleted." }
      end
    end
  end
end
