require_relative '../../proofs_init'

Proof::Output.suspend_devices :suite_results do
  Proof::Output.fail 'Fails Example'
end
