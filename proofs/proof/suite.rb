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
  output = Proof::Output.new
  string_io = Output::Devices.build_device :string_io, :name => :suite_proofs 
  existing = Proof::Output::summary_writer.device(:suite_results)
  output.push_device string_io
  output.push_device existing

  Proof::Suite.run "some_file_pattern", :output => output, :device => string_io

  summary = string_io.read

  proof 'Informs the user of the absence of files' do
    summary.prove { no_suite_files? }
  end

  proof 'Has no summary counts' do
    summary.prove { no_summary_counts? }
  end
end
