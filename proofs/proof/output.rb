require_relative '../proofs_init'
include Proof::SketchStyle

Proof::Output.info 'This is an info'
Proof::Output.pass 'This is a pass'
Proof::Output.fail 'This is a fail'
Proof::Output.error 'This is an error'
