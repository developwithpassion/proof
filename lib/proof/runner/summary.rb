module Proof
  module Runner
    class Summary
      include Initializer

      PASS_PATTERN = /Pass:.*$/
      FAIL_PATTERN = /-> Fail:.*$/
      ERROR_PATTERN = /Error:.*$/

      initializer :results

      def self.output(results)
        instance = new results
        instance.output
        output.status
      end

      def passes
        results.grep PASS_PATTERN
      end

      def fails
        results.grep FAIL_PATTERN
      end

      def errors
        results.grep ERROR_PATTERN
      end

      def status
        if [fails.count, errors.count].any? { |count| count > 0 }
          @status = :failure
        elsif passes.count > 0
          @status = :success
        else
          @status = :initialized
        end
 
        @status
      end

      def summary
        "Passed: #{passes.count}\n" \
        "Failed: #{fails.count}\n" \
        "Errors: #{errors.count}\n"
      end

      def output
        Output.summary summary
      end
    end
  end
end
