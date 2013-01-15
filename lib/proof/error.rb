module Proof
  class Error
    attr_reader :error

    def self.output(error)
      instance = new error
      instance.output
    end

    def initialize(error)
      @error = error
    end

    def backtrace
      @backtrace ||= @error.backtrace
    end

    def output     
      remove_proof_framework_frames
      Output.error error_message
      Output.backtrace backtrace.join("\n")
    end

    def remove_proof_framework_frames
      backtrace.reject! {|l| l =~ /proof\/lib\/proof/ }
    end

    def error_message
      filename_and_line_number = backtrace[0].gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
      "(#{error.class}) \"#{error.message}\" at #{filename_and_line_number}"
    end
  end
end
