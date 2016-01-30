require "pry"
require "decoplan/dsl"
require "decoplan/algorithms"  # HACK: for now

module Decoplan
  class Runner
    def run
      # FIXME: set _pry_.prompt, _pry_.prompt_name, possibly other _pry_ config vars
      context = Class.new
      context.extend(DSL)
      context.class_eval { binding.pry }  # rubocop:disable Lint/Debugger
    end
  end
end
