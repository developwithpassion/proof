module Proof
  class Execution
    attr_reader :obj_under_test
    attr_reader :blk

    def self.run(obj_under_test, blk)
      instance = new obj_under_test, blk
      instance.run
    end

    def initialize(obj_under_test, blk)
      @obj_under_test = obj_under_test
      @blk = blk
    end

    def run
      error = nil
      begin
        result = obj_under_test.instance_eval &blk
        method = result ? :pass : :fail
        messsage = Proof::Description.current
      rescue => error
        method = :error

        # backtrace = error.backtrace
        # line_detail = backtrace[0].gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
        # messsage = "(#{error.class}) \"#{error.message}\" at #{line_detail}"
      end
      Proof::Result.new method, error
      # Output.send method, messsage

      # if method == :error
      #   backtrace.reject! {|l| l =~ /proof\/lib\/proof/ }
      #   Output.debug backtrace.join("\n")
      # end
    end
  end
end
