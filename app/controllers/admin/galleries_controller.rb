class Admin::GalleriesController < Admin::CrudController
  def index
    respond_to do |f|
      f.json { render galleries: @galleries }
      f.html {}
    end
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    respond_to do |f|
      if @gallery.save
        f.html { redirect_to admin_galleries_path, notice: "Gallery added successfully." }
      else
        f.html { render "new", error: @gallery.errors.full_messages }
      end
    end
  end

  def update
    @gallery.update_attributes(params[:gallery])

    respond_to do |f|
      if @gallery.save
        f.html { redirect_to admin_galleries_path, notice: "Gallery updates successfully." }
      else
        f.html { render "edit", error: @gallery.errors.full_messages }
      end
    end
  end

  def destroy
    respond_to do |f|
      if @gallery.destroy
        f.html { redirect_to admin_galleries_path, notice: "Gallery deleted successfully." }
      else
        f.html { redirect_to admin_galleries_path, error: @gallery.errors.full_messages }
      end
    end
  end

end

