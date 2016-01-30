
require "decoplan/dsl"
require "decoplan/dive_profile"

RSpec.describe Decoplan::DSL do
  let(:dsl) { Class.new.extend(Decoplan::DSL) }

  it "can build a simple dive and apply buhlmann" do
    dsl.class_eval do
      dive "test" do
        level depth: 100, time: 70
      end.apply(:buhlmann)
    end
  end

  it "can build a simple dive and apply gradient factors" do
    dsl.class_eval do
      dive "test" do
        level depth: 100, time: 70
      end.apply(:buhlmann, 20, 85)
    end
  end

end
