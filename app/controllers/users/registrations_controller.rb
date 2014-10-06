class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    #resource.update_attribute(:admin, true)

    if resource.save
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_up(resource_name, resource)
      respond_with resource, :location => after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected
  def after_sign_up_path_for(resource)
    case resource
    when :user, User
      resource.admin? ? admin_people_path : root_path
    end
  end
end
