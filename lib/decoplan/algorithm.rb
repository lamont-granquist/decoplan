require "decoplan/dsl"
require "decoplan/helpers"

module Decoplan
  class Algorithm
    include Helpers

    attr_accessor :profile

    @@algorithms = {}  # rubocop:disable Style/ClassVars

    def initialize(profile, **_args)
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
