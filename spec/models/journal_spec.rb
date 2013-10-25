require 'spec_helper'

describe Journal do
  context "associations" do
    it { should have_many(:locations) }
    it { should have_many(:personnel_histories) }
  end

  context "validations" do
    it { should validate_presence_of :title }
  end
end
