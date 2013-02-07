require_relative '../proofs_init'

title 'Errors Within a Proof'

module ErrorProofs
  class Example
    def fail!
      raise
    end

    module Proof
      def continues?
        true
      end
    end
  end
end

def example
  ErrorProofs::Example.new
end

proof 'When an error is raised within a proof, subsequent proofs still run' do
  eg = example
  eg.prove { fail! }

  desc 'Continues to run'
  eg.prove { continues? }
end

