require_relative '../proofs_init'

# TODO turn on all loggers
Proof::Output.info 'This informs'
Proof::Output.pass 'This passes'
Proof::Output.fail 'This fails'
Proof::Output.error 'This is an error'
Proof::Output.backtrace 'This is a backtrace'
Proof::Output.details 'This is details'
# TODO reset logger levels to default
