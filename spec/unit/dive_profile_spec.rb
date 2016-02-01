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

  it "accepts a gas command" do
    profile.gas(o2: 18, he: 45)
    expect(profile.current_o2).to eql(18)
    expect(profile.current_he).to eql(45)
  end

  it "accepts a gas command with positional arguments" do
    profile.gas(18, 45)
    expect(profile.current_o2).to eql(18)
    expect(profile.current_he).to eql(45)
  end

  it "raises when o2 is passed both positionally and named" do
    expect { profile.gas(18, 45, o2: 32) }.to raise_error(RuntimeError)
  end

  it "raises when he is passed both positionally and named" do
    expect { profile.gas(18, 45, he: 30) }.to raise_error(RuntimeError)
  end

  it "accepts a level command" do
    profile.gas(o2: 18, he: 45)
    profile.level(depth: 100, time: 70)
    expect(profile.levels).to eql([{:depth=>100, :time=>70, :o2=>18, :he=>45}])
  end

  it "a level command with no gas set throws an error" do
    expect { profile.level(depth: 100, time: 70) }.to raise_error(RuntimeError)
  end

  it "gases can be set directly on the level" do
    profile.level(depth: 100, time: 70, o2: 18, he: 45)
    expect(profile.levels).to eql([{:depth=>100, :time=>70, :o2=>18, :he=>45}])
  end

  it "setting a gas on the level sets the current gas" do
    profile.gas(o2: 32, he: 0)
    profile.level(depth: 100, time: 20, o2: 18, he: 45)
    profile.level(depth: 120, time: 30)
    expect(profile.levels).to eql([
      {:depth=>100, :time=>20, :o2=>18, :he=>45},
      {:depth=>120, :time=>30, :o2=>18, :he=>45},
    ])
  end

  it "multiple levels can be set" do
    profile.gas(o2: 18, he: 45)
    profile.level(depth: 100, time: 20)
    profile.level(depth: 120, time: 30)
    profile.level(depth: 110, time: 10)
    expect(profile.levels).to eql([
      {:depth=>100, :time=>20, :o2=>18, :he=>45},
      {:depth=>120, :time=>30, :o2=>18, :he=>45},
      {:depth=>110, :time=>10, :o2=>18, :he=>45},
    ])
  end

  it "multiple levels with different gas can be set" do
    profile.gas(o2: 30, he: 30)
    profile.level(depth: 100, time: 20)
    profile.gas(o2: 50, he: 0)
    profile.level(depth: 70, time: 3)
    profile.gas(o2: 100, he: 0)
    profile.level(depth: 20, time: 10)
    expect(profile.levels).to eql([
      {:depth=>100, :time=>20, :o2=>30, :he=>30},
      {:depth=>70, :time=>3, :o2=>50, :he=>0},
      {:depth=>20, :time=>10, :o2=>100, :he=>0}
    ])
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
