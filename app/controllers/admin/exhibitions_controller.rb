class Admin::ExhibitionsController < Admin::CrudController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    params[:exhibitions_artists].each do |key, value|
      @exhibition.exhibitions_artists << ExhibitionsArtist.new(value)
    end if params[:exhibitions_artists]

    respond_to do |f|
      if @exhibition.save
        f.html { redirect_to admin_gallery_path(params[:gallery_id]) }
      else
      end
    end
  end

  def update
  end

  def destroy
    respond_to do |f|
      if @exhibition.delete
        f.html { redirect_to admin_exhibitions_path, notice: "Exhibition successfully deleted" }
      else
        f.html { redirect_to :back, error: @exhibitions.errors.full_messages }
      end
    end
  end
end
