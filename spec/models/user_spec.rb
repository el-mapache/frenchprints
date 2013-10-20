require 'spec_helper'

describe User do
  context "accessibility" do
    it { should allow_mass_assignment_of :email }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    it { should allow_mass_assignment_of :remember_me }
    it { should_not allow_mass_assignment_of :id }
  end

  context "validations" do
    it { should validate_presence_of :email }
    it { should allow_value("test@test.com").for(:email) }
    it { should_not allow_value("fake").for(:email) }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end

  describe "is_admin?" do
    it "returns whether or not the user is an admin" do
      create(:user).is_admin?.should eql(true) 
    end
  end
end
