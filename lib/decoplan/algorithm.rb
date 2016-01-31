require 'decoplan/dsl'

module Decoplan
  class Algorithm
    @@algorithms = {}  # rubocop:disable Style/ClassVars

    def initialize(profile, **args)
      @profile = profile
    end

    def self.name(*symbols)
      symbols.each do |symbol|
        @@algorithms[symbol] = self
        DSL.add_algorithm_to_dsl(symbol, self)
      end
    end

    def self.resolve(symbol)
      @@algorithms[symbol]
    end
  end
end
