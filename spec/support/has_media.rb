shared_examples_for "has_media" do
  before :each do
    @resource ||= FactoryGirl.create(described_class.to_s.downcase.to_sym)
  end

  describe "attributes and such" do
    it { should accept_nested_attributes_for :media}
    it { should have_many :media }

    it "is destroyed when its parent model is" do
      @resource.media.create(FactoryGirl.attributes_for(:medium))
      lambda do
        @resource.destroy
      end.should change(Medium, :count).by(-1)
    end
  end
end
