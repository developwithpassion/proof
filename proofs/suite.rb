require_relative 'proofs_init'

include Proof::Runner

Suite.run "proof/**/*.rb", "demos/**/*.rb"

