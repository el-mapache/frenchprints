class Admin::JournalsController < Admin::CrudController
  def index
    @journals = Journal.all
  end

  def new
    @journal = Journal.new
  end

  def show
  end

  def edit

  end

  def create
    @journal = Journal.new(params[:journal])

    respond_to do |f|
      if @journal.save
        f.html { redirect_to admin_journals_path, notice: "Resource successfully saved." }
      else
        f.html { render "new", error: @journal.errors.full_messages }
      end
    end
  end

  def update

  end

  def destroy
  end
end
