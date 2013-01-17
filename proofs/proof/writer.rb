require_relative '../proofs_init'

Proof.begin

def create_writer
  logger = Object.new
  default_level = :info
  
  Writer.new logger,default_level
end

module Proof
  class Writer
    module Proof
      def enabled?
        @enabled
      end
    end
  end
end

proof 'Initially enabled' do
  object_under_test = create_writer

  object_under_test.prove { enabled? }
end
