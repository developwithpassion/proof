require_relative '../proofs_init'

title 'The Prove Method'

module ProofProofs
  class Example
    module Proof
      def proven?
        true
      end
    end
  end

end

def example
  ProofProofs::Example.new
end

proof 'A failing proof' do
  Proof::Output.suspend_devices :suite_results do
    example.prove { not proven? }
  end
end

proof 'A passing proof' do
  example.prove { proven? }
end
