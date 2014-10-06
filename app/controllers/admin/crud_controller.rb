# Generate instance methods for the common actions of 
# simple crud controllers.
class Admin::CrudController < Admin::AdminController 
  before_filter :get_resource, only: [:show, :edit, :update, :destroy]
  before_filter :get_all, only: [:index]
  before_filter :new_resource, only: [:new, :create]

  # Is the controller namespaced? 
  def is_namespaced?
    self.class.name.include?("::")
  end
  
  private

  # Obtain a string of the controller's resource name.
  # For example, UsersController would return the string "User"
  #
  def derive_class_context
    context = clean_name(is_namespaced?)
  end

  # Remove all namespacing if necessary, then remove the string "Controller"
  # from the class.
  #
  def clean_name(namespaced = false)
    class_context = self.class.name
    class_context = class_context.split("::")[-1] if namespaced

    class_context.slice!(class_context.index("C")..-1)

    class_context
  end

  # Find all resources for the given class and set an instance variable.
  #
  # For example, given the string "Users", this method will set an
  # instance variable named @users and assign it the results 
  # of the ActiveRecord #all finder.
  #
  def get_all
    class_context = derive_class_context

    instance_variable_set("@#{class_context.downcase}", class_context.singularize.constantize.all)
  end

  # This method behaves the same as the preceeding one, except it finds
  # only the specified instance of the class.
  #
  def get_resource
    class_context = derive_class_context.singularize

    instance_variable_set("@#{class_context.downcase}", class_context.constantize.where(id: params[:id]).first)
  end

  # Create a new resource, initializing it with paramaters if they exist.
  def new_resource
    class_context = derive_class_context.singularize
    instance_attributes = params[class_context.downcase.to_sym]

    new_instance = if instance_attributes
                     class_context.constantize.new(instance_attributes)
                   else
                    class_context.constantize.new
                   end

    instance_variable_set("@#{class_context.downcase}", new_instance)
  end

end
