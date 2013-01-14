require_relative '../proofs_init'
include Proof::SketchStyle

Proof::Output.pass 'This passes'
Proof::Output.fail 'This fails'
Proof::Output.error 'This is an error'
