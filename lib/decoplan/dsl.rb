require 'decoplan/dive_profile'

module Decoplan
  class DSL < BasicObject
    def self.dive(name, &block)
      dive = DiveProfile.new
      dive.instance_eval(&block)
      dive
    end

    def self.help
      puts "FIXME: should give the user some help"
    end
  end
end
