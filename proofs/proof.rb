require_relative 'proofs_init'
require_relative 'thing'

include Proof::DSL

Proof::begin

desc 'A failing proof'
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

Proof::end


proof 'A passing proof' do
  thing = Thing.new
  thing.prove { some_method }
end


