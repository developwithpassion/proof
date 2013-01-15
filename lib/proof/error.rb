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
      @backtrace ||= @error.backtrace.extend Backtrace
    end

    def output     
      backtrace.remove_proof_framework_frames!
      Output.error error_message
      Output.backtrace "  #{backtrace.join("\n  ")}"
    end

    def error_message
      "(#{error.class}) \"#{error.message}\" at #{backtrace.first_frame}"
    end

    module Backtrace
      def first_frame
        first.gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
      end

      def remove_proof_framework_frames!
        reject! {|l| l =~ /proof\/lib\/proof/ }
      end
    end
  end
end
