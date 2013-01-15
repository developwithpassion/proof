require_relative '../proofs_init'

include Proof::SketchStyle

module Proof
  class ProofResult
    module Proof
      def error?
        @error.nil?
      end
      def passed?
        Output.debug "passed? == #{@method == :pass}"
        @method == :pass && !error?
      end
      def failed?
        Output.debug "failed? == #{@method == :fail}"
        @method == :fail && !error?
      end 
      def raised_an_error?
        Output.debug "raised_an_error? == #{@method == :error}"
        @method == :error && error?
      end
      def written?
        Output.debug "Displayed the result == #{@written == true}"
        @written
      end
    end
  end

  def some_error
    begin
      raise 
    rescue => error
      error
    end
  end
end


proof 'Passes' do

  execution = ProofExecution.new
  execution.obj_under_test = Object.new
  execution.blk = Proc.new { true }

  result = execution.run

  result.prove { passed? }
end

proof 'Fails' do
  execution = ProofExecution.new
  execution.obj_under_test = Object.new
  execution.blk = Proc.new { false }

  result = execution.run

  result.prove { failed? }
end

proof 'Raises an error' do
  execution = ProofExecution.new
  execution.obj_under_test = Object.new
  execution.blk = Proc.new { raise }

  result = execution.run

  result.prove { raised_an_error? }
end

