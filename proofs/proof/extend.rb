require_relative '../proofs_init'

title 'Extending an object with proof behaviour'

module ExtendProofs
  class Example
    module Proof
      def extended?
        true
      end
    end
  end
end

def example
  ExtendProofs::Example.new
end
proof 'Extends the object under test with the inner proof module' do
  item = example

  extender = Proof::Extend.new(item)
  extender.extend_obj

  item.prove { extended? }
end


proof 'Objects under test without an inner proof module can still be proven' do
  item = Object.new

  extender = Proof::Extend.new(item)
  extender.extend_obj

  item.prove { true }
end
