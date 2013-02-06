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

        instance = new files
        results = instance.run
        Summary.output(results)
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
        appender = Output.push_device_from_opts(:string_io) do
          files.each do |file|
            load file
          end
        end

        appender.readlines
      end

      class Summary
        include Initializer

        FAIL_PATTERN = /-> Fail:.*$/
        PASS_PATTERN = /Pass:.*$/
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
          summary = "#{summary}Failed: #{fails.count}\n"
          summary = "#{summary}Errors: #{errors.count}\n"

          Output.summary summary
        end
      end
    end
  end
end
