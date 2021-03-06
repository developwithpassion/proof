module Proof
  class Summary
    include Initializer

    PASS_PATTERN = /Pass:.*$/
    FAIL_PATTERN = /-> Fail:.*$/
    ERROR_PATTERN = /Error:.*$/

    initializer :results, :the_output

    def self.output(results, output)
      instance = new results, output
      instance.output
      instance.status
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
      if no_results? or any_failures?
        @status = :failure
      else any_successes?
        @status = :success
      end

      @status
    end

    def no_results?
      [passes.count, fails.count, errors.count].all? { |count| count == 0 }
    end

    def any_failures?
      [fails.count, errors.count].any? { |count| count > 0 }
    end

    def any_successes?
      [fails.count, errors.count].any? { |count| count > 0 }
    end

    def summary
      "Passed: #{passes.count}\n" \
      "Failed: #{fails.count}\n" \
      "Errors: #{errors.count}\n"
    end

    def output
      @the_output.summary summary
    end
  end
end
