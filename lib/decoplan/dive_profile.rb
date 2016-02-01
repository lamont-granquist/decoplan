
require "decoplan/algorithm"

module Decoplan
  class DiveProfile < BasicObject
    attr_accessor :levels
    attr_accessor :name

    attr_accessor :current_o2
    attr_accessor :current_he

    def initialize(name: nil)
      @name = name
      @levels = []
    end

    def gas(o2_p = nil, he_p = nil, o2: nil, he: nil)
      ::Kernel.raise "cannot specify positional and named parameters at the same time for o2" unless o2_p.nil? || o2.nil?
      ::Kernel.raise "cannot specify positional and named parameters at the same time for he" unless he_p.nil? || he.nil?
      @current_o2 = o2_p unless o2_p.nil?
      @current_o2 = o2 unless o2.nil?
      @current_he = he_p unless he_p.nil?
      @current_he = he unless he.nil?
    end

    def level(depth:, time:, he: nil, o2: nil)
      o2 ||= current_o2
      he ||= current_he
      ::Kernel.raise "no he percentage set" if he.nil?
      ::Kernel.raise "no o2 percentage set" if o2.nil?
      gas(o2: o2, he: he)
      levels.push(depth: depth, time: time, o2: o2, he: he)
    end

    def apply(algorithm, *params)
      Algorithm.resolve(algorithm).new(self, *params)
    end
  end
end
