require_relative '../proofs_init'

Proof::Output.info 'This informs. It prints at the info level.'
Proof::Output.pass 'This passes. It prints at the info level.'
Proof::Output.fail 'This fails. It prints at the info level.'
Proof::Output.error 'This is an error. It prints at the warn level.'
Proof::Output.backtrace 'This is a backtrace. It prints at the info error.'
Proof::Output.details 'This is details, but it won\'t print at this level.'

Proof::Output.push_level :debug
Proof::Output.details 'This is details. It prints at the debug level.'
Proof::Output.pop_level

Proof::Output.push_level :debug do
  Proof::Output.details 'This is details. It also prints at the debug level.'
end
