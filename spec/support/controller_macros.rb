module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in :user, admin # sign_in(scope, resource)
    end
  end 
end
