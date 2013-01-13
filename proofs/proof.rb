require_relative 'proofs_init'
require_relative 'thing'

proof 'A failing proof' do
  class Thing
    module Proof
      def some_method
        super
        true
      end
    end 
  end
  thing = Thing.new
  thing.prove { not some_method }
end

proof 'A passing proof' do
  thing = Thing.new
  thing.prove { some_method }
end
