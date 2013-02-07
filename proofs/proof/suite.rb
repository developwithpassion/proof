require_relative '../proofs_init'

title 'Suite'

Summary = String

class Summary
  module Proof
    def no_suite_files?
      downcase.include? 'suite has no files'
    end

    def no_summary_counts?
      return false if downcase.include? 'passed:'
      return false if downcase.include? 'failed:'
      return false if downcase.include? 'errors:'

      true
    end
  end
end

heading 'A suite with no files' do
  string_io = ::Proof::Output.summary_writer.push_device :string_io do
    Proof::Runner::Suite.run "some_file_pattern"
  end

  summary = string_io.read

  proof 'Informs the user of the absence of files' do
    summary.prove { no_suite_files? }
  end

  proof 'Has no summary counts' do
    summary.prove { no_summary_counts? }
  end
end
