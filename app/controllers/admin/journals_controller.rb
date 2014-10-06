class Admin::JournalsController < Admin::CrudController
  def index
    respond_to do |f|
      f.json { render json: @journals }
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
      if @journal.save
        f.html { redirect_to admin_journals_path, notice: "Resource successfully saved." }
      else
        f.html { render "new", error: @journal.errors.full_messages }
      end
    end
  end

  def update
    respond_to do |f|
      if @journal.update_attributes(params[:journal])
        f.html { redirect_to admin_journals_path, notice: "Resource successfully updated." }
      else
        f.html { render "edit", error: @journal.errors.full_messages }
      end
    end
  end

  def destroy
    respond_to do |f|
      if @journal.destroy
        f.html { redirect_to admin_journals_path, notice: "Resource successfully deleted." }
      else
        f.html { redirect_to admin_journals_path, error: "Something went wrong." }
      end
    end
  end
end
