module Decoplan
  class DiveProfile < BasicObject
    attr_accessor :levels

    def initialize
      @levels = []
    end

    def level(depth:, time:)
      levels.push({
        depth: depth,
        time: time,
      })
    end

    def apply(algorithm, *params)
      algorithm.new(self, *params)
    end
  end
end
