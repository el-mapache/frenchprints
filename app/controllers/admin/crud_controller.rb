class Admin::CrudController < Admin::AdminController 
  before_filter :get_resource, only: [:show, :edit, :update, :destroy]

  private

  def get_resource
    class_context = self.class.to_s.split("::")[1]
    class_context.slice!(class_context.index("C")..-1)
    class_context = class_context.singularize

    instance_variable_set("@#{class_context.downcase}", class_context.constantize.find(params[:id]))
  end

end
