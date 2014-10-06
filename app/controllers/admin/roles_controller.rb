class Admin::RolesController < Admin::CrudController
  def index
  end

  def new
  end

  def show
  end

  def create
    respond_to do |f|
      if @role.save
        f.html { redirect_to admin_roles_path, notice: "Record created successfully." }
      else
        f.html { render "new", error: @role.errors.full_messages }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |f|
      if @role.save!
        f.html { redirect_to admin_roles_path, notice: "Record updated successfully." }
      else
        f.html { render "edit", error: @role.errors.full_messages }
      end
    end
  end

  def destroy
    respond_to do |f|
      if @role.delete
        f.html { redirect_to admin_roles_path, notice: "Record successfully destroyed" }
      else
        f.html { redirect_to :back, error: "Something went wrong." }
      end
    end
  end
end
