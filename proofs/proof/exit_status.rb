require_relative '../proofs_init'

title 'Exit Status'

def suite
  Proof::Suite
end

proof 'A suite with no files is a failure' do
  exit_status = suite.run 'some_file_pattern'
  exit_status.prove { self == :failure }
end

proof 'A suite with any failures is a failure' do
  exit_status = suite.run 'example_proof_files/fails.rb'
  exit_status.prove { self == :failure }
end

proof 'A suite with only passes is a success' do
  exit_status = suite.run 'example_proof_files/passes.rb'
  exit_status.prove { self == :success }
end
