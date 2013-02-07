require_relative 'proofs_init'

Proof::Suite.run "proof/**/*.rb", "demos/**/*.rb"
