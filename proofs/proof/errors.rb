require_relative '../proofs_init'

include Proof::SketchStyle

Proof::begin

class ThingThatRaisesAnError
  module Proof
    def raises_an_error
      begin
        raise
      rescue
        true
      end
    end
  end
end

heading 'When an error is raised subsequent proofs still run'

desc 'Raises an error'
item = ThingThatRaisesAnError.new
item.prove{ raises_an_error }

ran_next = false
item.instance_eval { ran_next = true }

desc 'Still runs'
item.prove{ ran_next }
