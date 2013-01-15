require_relative '../proofs_init'

Proof.begin

desc 'Error and backtrace are output'
item = Object.new

item.prove { raise 'This is an error' }
