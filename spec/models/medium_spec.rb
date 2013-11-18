require 'spec_helper'

describe Medium do
  it { should belong_to :imagable }
  it { should allow_mass_assignment_of :image }
  it { should_not allow_mass_assignment_of :id }
end
