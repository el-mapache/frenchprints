class Admin::PeopleController < Admin::CrudController
  skip_before_filter :get_all

  def index
    @people = Person.all_with_roles
    respond_to do |f|
      f.json { render json: @people }
      f.html {}
    end
  end

  def new
    @birth = @person.locations.build(event_name: "birth")
    @death = @person.locations.build(event_name: "death")
  end

  def show
    @person = PersonPresenter.new(@person)
  end

  def create
    respond_to do |f|
      if @person.save
        f.html { redirect_to admin_people_path, notice: "Record successfully added" }
      else
        f.html { render "new", error: @person.errors.full_messages }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |f|
      if @person.update_attributes(params[:person])
        f.html { redirect_to admin_people_path, notice: "Record successfully updated."}
        f.json {}
      else
        f.html {render "edit", error: @person.errors.full_messages }
        f.json {}
      end
    end
  end

  def destroy
    respond_to do |f|
      if @person.delete
        f.html { redirect_to admin_people_path, notice: "Record successfully deleted" }
      else
        f.html { redirect_to :back, error: "Something went wrong." }
      end
    end
  end
end

