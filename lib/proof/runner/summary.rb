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

      def output
        summary = "Passed: #{passes.count}\n"
        summary << "Failed: #{fails.count}\n"
        summary << "Errors: #{errors.count}\n"

        Output.summary summary

        # return exit_code
      end

    #   def exit_code
    #     ok = passes.count <= 0
    #     failures = fails.count <= 0
    #     errors = errors.count <= 0

    #     return ExitCodes.errors if errors

    #     return ExitCodes.failures if failures

    #     return ExitCodes.ok if failures




    #     if failures
    #       return 0
    #     elsif fatal
    #       return 1
    #     else
    #       return -1
    #     end
    #   end
    end
  end
end
