require_relative '../proofs_init'

title 'Suite'

module SuiteProofs
  class Summary
    include Initializer

    initializer :text

    module Proof
      def no_suite_files?
        text.downcase.include? 'suite has no files'
      end

      def no_summary_counts?
        return false if text.downcase.include? 'passed:'
        return false if text.downcase.include? 'failed:'
        return false if text.downcase.include? 'errors:'

        true
      end
    end
  end
end

heading 'A suite with no files' do
  string_io = ::Proof::Output.summary_writer.push_device :string_io do
    Proof::Runner::Suite.run "some_glob"
  end

  summary = SuiteProofs::Summary.new string_io.read

  proof 'Informs the user of the absence of files' do
    summary.prove { no_suite_files? }
  end

  proof 'Has no summary counts' do
    summary.prove { no_summary_counts? }
  end
end
