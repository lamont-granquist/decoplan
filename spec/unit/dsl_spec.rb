
require 'decoplan/dsl'
require 'decoplan/dive_profile'

RSpec.describe Decoplan::DSL do
  let(:dsl) { Class.new.extend(Decoplan::DSL) }

  it "has a help method" do
    dsl.help
  end

  it "dive can be used to construct a dive plan" do
    dsl.dive
  end

  it "the default name of a dive is nil" do
    expect(dsl.dive.name).to be nil
  end

  it "we can also set a name from the dsl" do
    expect(dsl.dive("foo").name).to eql "foo"
  end
end
