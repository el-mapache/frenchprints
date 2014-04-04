require 'spec_helper'

describe PersonPresenter do
  let(:presenter) { PersonPresenter.new(create(:person)) }
  it "has accessible attributes" do
    %w(person name blurb bio birth death roles).each do |attr|
      expect(presenter.respond_to?(attr.to_sym)).to be_true
    end    
  end

end
