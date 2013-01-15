module Proof
  class Result
    attr_reader :status,:error
    def initialize(status, error = nil)
      @status = status
      @error = error
    end

    def write
      Output.send status, "#{Description.current}"

      if status == :error
        backtrace = error.backtrace
        line_detail = backtrace[0].gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
        messsage = "(#{error.class}) \"#{error.message}\" at #{line_detail}"

        backtrace.reject! {|l| l =~ /proof\/lib\/proof/ }
        Output.backtrace backtrace.join("\n")
      end
    end
  end
end
