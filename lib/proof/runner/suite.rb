require 'stringio'
require 'pathname'

module Proof
  module Runner
    class Suite
      include Initializer

      initializer :files

      def self.run(*args)
        base_dir = File.expand_path(File.dirname(caller[0]))
        file_patterns = flatten(args)
        files = glob(file_patterns, base_dir)

        if files.empty?
          ::Proof::Output.summary "Suite has no files"
          # return ExitCode.suite_has_no_files
        end

        instance = new files
        results = instance.run

        # exit_code = Summary.output(results)

        # return exit_code
      end

      def self.glob(patterns, base_dir)
        files = []
        patterns.each do |pattern|
          pattern = Pathname.new(pattern).absolute? ? pattern : File.join(base_dir, pattern)
          files.concat Dir.glob(pattern)
        end
        files
      end

      def self.flatten(args)
        files = []
        args.each do |pattern|
          files.concat pattern.is_a?(Array) ? pattern : [pattern]
        end
        files
      end

      def run
        appender = Output.push_device(:string_io) do
          files.each do |file|
            load file
          end
        end

        appender.readlines
      end

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
          summary = ''
          # summary = "Passed: #{passes.count}\n"
          # summary = "#{summary}Failed: #{fails.count}\n"
          # summary = "#{summary}Errors: #{errors.count}\n"

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

      # module ExitCodes
      #   extend self

      #   def ok
      #     -1
      #   end

      #   def failures
      #     0
      #   end

      #   def fatal
      #     1
      #   end

      #   def suite_has_no_files
      #     2
      #   end
      # end
    end
  end
end
