require_relative '../proofs_init'

title 'Suite Exit Status'


module Proof
  module Runner
    class Summary
      module Proof

      end
    end
  end
end

def exit_status(file_pattern)
  Proof::Runner::Suite.run file_pattern
end

proof 'A suite with no files' do
  puts Proof::Runner::Suite.run "some_glob"
end


