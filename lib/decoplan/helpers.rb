module Decoplan
  module Helpers
    # Ambient pressure changing linearly with time (Open Circuit).
    #
    # @param p_inert [Numeric] initial partial pressure of inert gas in compartment (bar)
    # @param p_alv [Numeric] initial alveolar pressure (bar)
    # @param half_time [Numeric] compartment half time for inert gas (min)
    # @param dt [Numeric] time of level (min)
    # @return [Numeric] final partial pressure of inert gas in compartment
    def haldane_equation(p_inert, p_alv, half_time, dt)
      schreiner_equation(p_inert, p_alv, half_time, 0, dt)
    end

    # Ambient pressure changing linearly with time (Open Circuit).
    #
    # @param p_inert [Numeric] initial partial pressure of inert gas in compartment (bar)
    # @param p_alv [Numeric] initial alveolar pressure (bar)
    # @param half_time [Numeric] compartment half time for inert gas (min)
    # @param r_amb [Numeric] rate of change of the alveolar pressure (bar/min)
    # @param dt [Numeric] time of level (min)
    # @return [Numeric] final partial pressure of inert gas in compartment
    def schreiner_equation(p_inert, p_alv, half_time, r_amb, dt)
      k = Math.log(2) / half_time
      p_alv + r_amb * ( dt - 1.0 / k ) - ( p_alv - p_inert - r_amb / k ) * Math.exp( -k * dt )
    end
  end
end
