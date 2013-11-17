module ControllerMacros
  # Login a fake admin so the tests dont fail
  # You have to set the devise mapping, not sure why
  #
  # The sign_in method takes a scope and a specific resource.
  # The scope refers to the class of the resource.
  #
  # The resource is an instance of the source,
  # in this case, User and admin = User.create
  #
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in :user, admin # sign_in(scope, resource)
    end
  end 
end
