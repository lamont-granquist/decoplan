require 'pry'

module Decoplan
  class Runner
    def run
      # FIXME: set _pry_.prompt, _pry_.prompt_name, possibly other _pry_ config vars
      context = Class.new(DSL)
      context.class_eval { binding.pry }
    end
  end
end
