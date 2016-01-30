module Decoplan
  class Algorithm
    @@algorithms = {}  # rubocop:disable Style/ClassVars

    def initialize(profile, *_args)
      @profile = profile
    end

    def self.name(symbol)
      @@algorithms[symbol] = self
    end

    def self.resolve(symbol)
      @@algorithms[symbol]
    end
  end
end
