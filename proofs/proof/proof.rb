require_relative '../proofs_init'
require_relative 'thing'

class Thing
  module Proof
    def proven?
      true
    end
  end
end

def thing
  Thing.new
end

proof 'A failing proof' do
  thing.prove { not proven? }
end

proof 'A passing proof' do
  thing.prove { proven? }
end
