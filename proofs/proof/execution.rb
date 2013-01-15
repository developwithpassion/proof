require_relative '../proofs_init'

module Proof
  class Result
    module Proof
      def error?
        !@error.nil?
      end
      def passed?
        Output.details "passed? == #{@status == :pass}"
        @status == :pass && !error?
      end
      def failed?
        Output.details "failed? == #{@status == :fail}"
        @status == :fail && !error?
      end 
      def raised_an_error?
        Output.details "raised_an_error? == #{@status == :error}"
        @status == :error && error?
      end
      def written?
        Output.details "Displayed the result == #{@written == true}"
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

def execution(blk)
  obj_under_test = Object.new
  execution = Proof::Execution.new obj_under_test, blk
end

proof 'Passes' do
  blk = Proc.new { true }
  result = execution(blk).run

  result.prove { passed? }
end

proof 'Fails' do
  blk = Proc.new { false }
  result = execution(blk).run

  result.prove { failed? }
end

proof 'Raises an error' do
  blk = Proc.new { raise }
  result = execution(blk).run

  result.prove { raised_an_error? }
end

