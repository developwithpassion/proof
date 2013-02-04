module Proof
  module Runner
    class Suite
      include Initializer
      include Events::Subscriber

      attr_writer :errors
      attr_writer :failures
      attr_writer :passes

      initializer :files
      
      def errors
        @errors ||= 0
      end

      def passes
        @passes ||= 0
      end

      def failures
        @failures ||= 0
      end

      def self.run(glob_pattern)
        files = Dir.glob(glob_pattern)
        instance = new files
        instance.run_proofs
      end

      def run_proofs
        files.each do|file|
          load file
        end
        Output.title summary
      end

      handle :pass do|ignored|
          self.passes += 1
      end

      handle :fail do|ignored|
          self.failures += 1
      end

      handle :error do|ignored|
          self.errors += 1
      end

      def summary
        summary = "Passed: #{self.passes}\n"
        summary = "#{summary}Failed: #{self.failures}\n"
        summary = "#{summary}Errors: #{self.errors}\n"
        summary
      end
    end
  end
end
