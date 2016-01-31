
require "decoplan/algorithm/buhlmann"
require "decoplan/dive_profile"

RSpec.describe Decoplan::Algorithm::Buhlmann do
  it "after 8 half times on 32% the first compartment is nearly saturated" do
    dive_profile = Decoplan::DiveProfile.new
    dive_profile.level(depth: 4.0, time: 4 * 8)
    buhlmann = Decoplan::Algorithm::Buhlmann.new(dive_profile)
    buhlmann.compute
    expect(buhlmann.compartments[0][:n2]).to be_between(2.71, 2.72)
  end
end
