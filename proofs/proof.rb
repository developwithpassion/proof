require_relative 'proofs_init'
require_relative 'thing'

desc "A failing proof"
Proof.start do
  thing = Thing.new
  thing.prove { not some_method }
end

Proof.start "A passing proof" do
  thing = Thing.new
  thing.prove { some_method }
end
