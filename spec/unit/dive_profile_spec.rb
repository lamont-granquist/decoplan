require "decoplan/dive_profile"

RSpec.describe Decoplan::DiveProfile do
  let(:name) { "test" }
  let(:profile) { described_class.new(name: name) }

  it "sets the name by default" do
    expect(profile.name).to eql "test"
  end

  it "the name is nil by default" do
    profile2 = described_class.new
    expect(profile2.name).to be nil
  end

  it "the name has an accessor" do
    profile.name = "changed"
    expect(profile.name).to eql("changed")
  end

  it "there are no levels by default" do
    expect(profile.levels).to eql([])
  end

  it "accepts a level argument" do
    profile.level(depth: 100, time: 70)
    expect(profile.levels).to eql([{ depth: 100, time: 70 }])
  end

  it "multiple levels can be set" do
    profile.level(depth: 100, time: 20)
    profile.level(depth: 120, time: 30)
    profile.level(depth: 110, time: 10)
    expect(profile.levels).to eql([{ depth: 100, time: 20 }, { depth: 120, time: 30 }, { depth: 110, time: 10 }])
  end

  it "we can apply an algorithm" do
    klass = double("Decoplan::Algorithm::Buhlmann class")
    instance = double("Decoplan::Algorithm::Buhlmann instance")
    expect(Decoplan::Algorithm).to receive(:resolve).with(:buhlmann).and_return(klass)
    expect(klass).to receive(:new).with(profile).and_return(instance)
    expect(profile.apply(:buhlmann)).to eql(instance)
  end

  it "we can pass args to an algorithm" do
    klass = double("Decoplan::Algorithm::Buhlmann class")
    instance = double("Decoplan::Algorithm::Buhlmann instance")
    expect(Decoplan::Algorithm).to receive(:resolve).with(:buhlmann).and_return(klass)
    expect(klass).to receive(:new).with(profile, 20, 85).and_return(instance)
    expect(profile.apply(:buhlmann, 20, 85)).to eql(instance)
  end
end
