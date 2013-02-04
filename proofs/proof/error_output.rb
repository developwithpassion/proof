require_relative '../proofs_init'

proof 'Error and backtrace are output' do
  item = Object.new

  item.prove { raise 'This is an error' }
end
