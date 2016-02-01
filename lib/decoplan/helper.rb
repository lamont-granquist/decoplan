require "decoplan/helpers"

RSpec.describe Decoplan::Helpers do
  pressure_values = {
    atm: {
      atm: 1.00000,
      bar: 1.01325,
      mmhg: 759.999952,
      pascal: 101325.0000,
      torr: 760.0000,
      fsw: 33.43725,
      msw: 10.1325,
    },
  }
  # FIXME: add more tests.

  class Test
    extend Decoplan::Helpers
  end

  pressure_values.each do |from, to_hash|
    to_hash.each do |to, value|
      delta = 0.001
      it "conversion of 1 #{from} to #{value} #{to} within #{delta}" do
        expect(Test.convert(1.0, from, to)).to be_within(delta).of(value)
      end
    end
  end
end
