require "decoplan/algorithm"
require "decoplan/dive_profile"

module Decoplan
  class Algorithm
    class Buhlmann < Algorithm
      attr_accessor :lo
      attr_accessor :hi

      attr_accessor :compartments

      N2_HALF = [ 4.0, 5.0, 8.0, 12.5, 18.5, 27.0, 38.3, 54.3, 77.0, 109.0, 146.0, 187.0, 239.0, 305.0, 390.0, 498.0, 635.0 ]
      N2_A = [ 1.2599, 1.2599, 1.0000, 0.8618, 0.7562, 0.6667, 0.5600, 0.4947, 0.4500, 0.4187, 0.3798, 0.3497, 0.3223, 0.2971, 0.2737, 0.2523, 0.2327 ]
      N2_B = [ 0.5050, 0.5050, 0.6514, 0.7222, 0.7725, 0.8125, 0.8434, 0.8693, 0.8910, 0.9092, 0.9222, 0.9319, 0.9403, 0.9477, 0.9544, 0.9602, 0.9653 ]
      HE_HALF = [ 1.51, 1.88, 3.02, 4.72, 6.99, 10.21, 14.48, 20.53, 29.11, 41.20, 55.19, 70.69, 90.34, 115.29, 147.42, 188.24, 240.03 ]
      HE_A = [ 1.7424, 1.6189, 1.3830, 1.1919, 1.0458, 0.9220, 0.8205, 0.7305, 0.6502, 0.5950, 0.5545, 0.5333, 0.5189, 0.5181, 0.5176, 0.5172, 0.5119 ]
      HE_B = [ 0.4245, 0.4770, 0.5747, 0.6527, 0.7223, 0.7582, 0.7957, 0.8279, 0.8553, 0.8757, 0.8903, 0.8997, 0.9073, 0.9122, 0.9171, 0.9217, 0.9267 ]

      name :buhlmann, :zhl16b

      def initialize(profile, lo: 100, hi: 100)
        super
        @lo = lo
        @hi = hi
      end

      def compute
        reset_compartments!
        deco_profile = DiveProfile.new
        apply_profile(deco_profile)
        compute_deco(deco_profile)
        deco_profile
      end

      def reset_compartments!
        @compartments = (0..15).map { { n2: 0.79, he: 0.0 } }
      end

      private

      def apply_profile(deco_profile)
        profile.levels.each do |level|
          deco_profile.level level
          haldane_step(level)
        end
      end

      def haldane_step(level)
        @compartments = compartments.map.with_index do |p_inert, i|
          # FIXME: alveolar pressure
          {
            n2: haldane_equation(p_inert[:n2], level.depth * (1.0 - level.he - level.o2), N2_HALF[i], level.time),
            he: haldane_equation(p_inert[:he], level.depth * level.he, HE_HALF[i], level.time),
          }
        end
      end

      def compute_deco(deco_profile)
        deco_profile
      end
    end
  end
end
