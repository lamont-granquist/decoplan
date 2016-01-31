require "decoplan/algorithm"
require "decoplan/dive_profile"

module Decoplan
  class Algorithm
    class Buhlmann < Algorithm
      attr_accessor :lo
      attr_accessor :hi

      attr_accessor :compartments

      N2HALF = [ 4.0, 5.0, 8.0, 12.5, 18.5, 27.0, 38.3, 54.3, 77.0, 109.0, 146.0, 187.0, 239.0, 305.0, 390.0, 498.0, 635.0 ]

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
        @compartments = (0..15).map { 0.79 }
      end

      private

      def apply_profile(deco_profile)
        profile.levels.each do |level|
          deco_profile.level level
        end
      end

      def compute_deco(_deco_profile)
      end

    end
  end
end
