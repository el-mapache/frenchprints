class Admin::RepresentationsController < Admin::CrudController
  skip_before_filter :create

  def create
    @person = Person.find(params[:person_id])

    params[:representations].each do |k,v|
      @person.represent(v["representee"], v["start_date"], v["end_date"])
    end

    respond_to do |f|
      if @person.save
        f.html { redirect_to admin_person_path(params[:person_id]), notice: "Representation saved" }
      else
        f.html { redirect_to :back, @person.error.full_messages }
      end  
    end
  end

  def destroy
    respond_to do |f|
      if @representation.delete
        f.html { redirect_to admin_person_path(params[:person_id]), notice: "Representation removed successfully" }
      end
    end
  end

end

