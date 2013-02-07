require_relative '../proofs_init'

title 'Exit Status'

proof 'A suite with no files is a failure' do
  exit_status = Proof::Runner::Suite.run 'some_file_pattern'
  exit_status.prove { self == :failure }
end

proof 'A suite with any failures is a failure' do
  exit_status = Proof::Runner::Suite.run 'example_proof_files/fails.rb'
  exit_status.prove { self == :failure }
end

proof 'A suite with only passes is a success' do
  exit_status = Proof::Runner::Suite.run 'example_proof_files/passes.rb'
  exit_status.prove { self == :success }
end
