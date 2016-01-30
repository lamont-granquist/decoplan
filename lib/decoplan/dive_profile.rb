
require 'decoplan/algorithm'

module Decoplan
  class DiveProfile < BasicObject
    attr_accessor :levels
    attr_accessor :name

    def initialize(name: nil)
      @name = name
      @levels = []
    end

    def level(depth:, time:)
      levels.push(        depth: depth,
                          time: time)
    end

    def apply(algorithm, *params)
      Algorithm.resolve(algorithm).new(self, *params)
    end
  end
end
