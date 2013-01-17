require_relative '../proofs_init'


# TODO turn on all loggers
log_level = Logging.logger.root.level
Logging.logger.root.level = :debug


Proof::Output.info 'This informs'
Proof::Output.pass 'This passes'
Proof::Output.fail 'This fails'
Proof::Output.error 'This is an error'
Proof::Output.backtrace 'This is a backtrace'
Proof::Output.details 'This is details'



Proof::Output.disable
Proof::Output.info 'This informs'
Proof::Output.pass 'This passes'
Proof::Output.fail 'This fails'
Proof::Output.error 'This is an error'
Proof::Output.backtrace 'This is a backtrace'
Proof::Output.details 'This is details'

# Proof::Output.reset_levels

# TODO reset logger levels to default
Logging.logger.root.level = log_level
