require "decoplan/dive_profile"

module Decoplan
  module DSL
    def dive(name = nil, &block)
      dive = DiveProfile.new(name: name)
      dive.instance_eval(&block) if block_given?
      dive
    end

    def help
      puts "FIXME: should give the user some help"
    end

    def self.add_algorithm_to_dsl(symbol, klass)
      define_method symbol do |profile, *args|
        klass.new(profile, *args)
      end
    end
  end
end
