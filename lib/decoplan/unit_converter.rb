
module Decoplan
  class UnitConverter
    attr_accessor :matrix

    def initialize
      @matrix = {}
    end

    def conversion(from, to, value)
      set(from, from, 1.0)
      set(to, to, 1.0)
      symmetric_set(from, to, value)
    end

    def symmetric_set(from, to, value)
      set(from, to, value)
      set(to, from, 1.0 / value)
    end

    def set(from, to, value)
      matrix[from] ||= {}
      matrix[from][to] = value
      matrix[to].each do |to2, value2|
        unless matrix[from][to2]
          symmetric_set(from, to2, value * value2)
        end
      end
    end

    def convert(value, from, to)
      unless matrix[from] && matrix[from][to]
        raise "no conversion from #{from} to #{to}"
      end
      value * matrix[from][to]
    end

    def create(&block)
      instance_eval(&block)
      self
    end
  end
end
