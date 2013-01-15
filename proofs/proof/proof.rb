require_relative '../proofs_init'
require 'proof/thing'

class Thing
  module Proof
    def some_method
      super
      true
    end
  end 
end

Proof.begin

desc 'A failing proof'
thing = Thing.new
thing.prove { not some_method }

Proof.end


proof 'A passing proof' do
  thing = Thing.new
  thing.prove { some_method }
end


