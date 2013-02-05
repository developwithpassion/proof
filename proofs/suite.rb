require_relative 'proofs_init'

Proof::Runner::Suite.run 'proof/**/*.rb', 'demo/**/*.rb'

