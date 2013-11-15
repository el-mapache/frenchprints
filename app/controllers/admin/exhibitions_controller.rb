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
    if @exhibition.save
      params[:exhibitions_artists].each do |key, value|
        @exhibition.exhibitions_artists << ExhibitionsArtist.new(value)
      end if params[:exhibitions_artists]
    end

    respond_to do |f|
      if @exhibition.save
        f.html { redirect_to admin_gallery_path(params[:gallery_id]), notice: "Exhibition created successfully" }
      else
        f.html { render "new", error: @exhibition.errors.full_messages}
      end
    end
  end

  def update
    params[:exhibitions_artists].each do |key, value|
      @exhibition.exhibitions_artists.create(value)
    end if params[:exhibitions_artists]

    respond_to do |f|
      if @exhibition.update_attributes(params[:exhibition])
        f.html { redirect_to admin_gallery_path(params[:gallery_id]), notice: "Exhibition successfully updated" }
      else
        f.html { render "edit", error: @exhibition.errors.full_messages }
      end
    end
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
