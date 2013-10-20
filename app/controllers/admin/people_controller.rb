class Admin::PeopleController < Admin::AdminController
  before_filter :get_person, only: [:show, :edit, :create, :update, :destroy]

  def index
    @people = Person.all_with_roles
  end

  def new
    @person = Person.new
  end

  def show
  end

  def create
    @person = Person.new(params[:person])

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
    @person.update_attributes(params[:person])

    respond_to do |f|
      if @person.save
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

  private
  def get_person
    @person = Person.find(params[:id])
  end
end