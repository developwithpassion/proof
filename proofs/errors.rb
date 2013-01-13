require_relative 'proofs_init'

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

desc 'When an error is raised subsequent proofs still run'
item = ThingThatRaisesAnError.new
item.prove{ raises_an_error }

ran_next = false
item.prove do
  ran_next = true
end

item.prove{ ran_next }



