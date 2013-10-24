require 'spec_helper'

describe Journal do
  context "Associations" do
    it { should have_many(:locations).through(:personnel_locations) }
  end
end
