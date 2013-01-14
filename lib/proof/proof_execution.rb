module Proof
  class ProofExecution
    attr_accessor :obj_under_test
    attr_accessor :blk

    def run
      error = nil
      begin
        result = obj_under_test.instance_eval &blk
        method = result ? :pass : :fail
        messsage = Proof::description
      rescue => error
        method = :error

        # backtrace = error.backtrace
        # line_detail = backtrace[0].gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
        # messsage = "(#{error.class}) \"#{error.message}\" at #{line_detail}"
      end
      ProofResult.new(method, error)
      # Output.send method, messsage

      # if method == :error
      #   backtrace.reject! {|l| l =~ /proof\/lib\/proof/ }
      #   Output.debug backtrace.join("\n")
      # end
    end
  end
end
