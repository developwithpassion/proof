require_relative '../proofs_init'

title 'Exit Status'

proof 'A suite with no files is a failure' do
  exit_status = Proof::Runner::Suite.run 'some_file_pattern'

  exit_status.prove { self == :failure }
end

proof 'A suite with any failures is a failure' do
  exit_status = Proof::Runner::Suite.run 'some_file_pattern'

  exit_status.prove { self == :failure }
end
