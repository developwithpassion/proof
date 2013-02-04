require_relative '../proofs_init'

Proof.begin

module ErrorsProofs
  class Example
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
end

def example
  ErrorsProofs::Example.new
end

heading 'When an error is raised subsequent proofs still run' do
  desc 'Raises an error'

  item = example
  item.prove{ raises_an_error }

  ran_next = false
  item.instance_eval { ran_next = true }

  desc 'Still runs'
  item.prove{ ran_next }
end

