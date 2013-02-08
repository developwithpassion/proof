require_relative '../proofs_init'

proof 'Error and backtrace are output' do
  item = Object.new

  Proof::Output.suspend_devices :suite_results do
    item.prove { raise 'This is an error' }
  end
end
