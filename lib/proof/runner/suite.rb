require 'stringio'

module Proof
  module Runner
    class Suite
      include Initializer

      initializer :files

      def self.run_globs(*glob_patterns)
        files = []
        glob_patterns.each do|pattern|
          files.concat Dir.glob(pattern)
        end
        run(files)
      end

      def self.run(files)
        instance = new files
        results = instance.run
        Summary.output(results)
      end

      def run
        appender = Logging::Appenders::StringIo.new(:runner)

        Output.push_appender appender do
          files.each do|file|
            puts "The file is #{file}"
            load file
          end
        end

        appender.readlines
      end

      class Summary
        include Initializer

        FAIL_PATTERN = /-> Fail:.*$/
        PASS_PATTERN = /\sPass:.*$/
        ERROR_PATTERN = /\sError:.*$/

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
