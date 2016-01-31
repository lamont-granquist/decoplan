
require "decoplan"

RSpec.describe Decoplan::DSL do
  let(:dsl) { Class.new.extend(Decoplan::DSL) }

  %w{buhlmann zhl16b}.each do |alg|
    it "can build a simple dive and apply #{alg}" do
      dsl.class_eval do
        dive "test" do
          level depth: 100, time: 70
        end.apply(alg.to_sym)
      end
    end

    it "can build a simple dive and apply #{alg} gradient factors" do
      dsl.class_eval do
        dive "test" do
          level depth: 100, time: 70
        end.apply(alg.to_sym, lo: 20, hi: 85)
      end
    end

    it "can build a simple dive and apply #{alg} on the DSL" do
      d = nil
      dsl.class_eval do
        d = dive "test" do
          level depth: 100, time: 70
        end
      end
      dsl.send(alg.to_sym, d)
    end

    it "can build a simple dive and apply #{alg} gradient factors on the DSL" do
      d = nil
      dsl.class_eval do
        d = dive "test" do
          level depth: 100, time: 70
        end
      end
      dsl.send(alg.to_sym, d, lo:20, hi:85)
    end
  end

end
