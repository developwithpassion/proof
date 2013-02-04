require 'stringio'

module Proof
  module Runner
    class Suite
      include Initializer
      
      attr_reader :passes
      attr_reader :fails
      attr_reader :errors

      FAIL_PATTERN = /-> Fail:/
      PASS_PATTERN = /\sPass:/
      ERROR_PATTERN = /\sError:/

      initializer :files
      
      def self.run(glob_pattern)
        files = Dir.glob(glob_pattern)
        output = StringIO.new
        instance = new files
        instance.run_proofs
      end

      def calculate_results(output)
        @passes = output.scan(PASS_PATTERN).count
        @fails = output.scan(FAIL_PATTERN).count
        @errors = output.scan(ERROR_PATTERN).count
      end

      def run_proofs
        appender = Logging::Appenders::StringIo.new(:runner)

        Output.push_appender appender do
          files.each do|file|
            load file
          end
        end

        output = appender.readlines.join("\n")
        calculate_results output

        Output.title summary
      end


      def summary
        summary = "Passed: #{self.passes}\n"
        summary = "#{summary}Failed: #{self.fails}\n"
        summary = "#{summary}Errors: #{self.errors}\n"
      end
    end
  end
end
