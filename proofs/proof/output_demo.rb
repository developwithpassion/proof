require_relative '../proofs_init'

heading 'Output demonstration'

level = Proof::Output.instance.level

Proof::Output.info "Info @ #{level}"
Proof::Output.pass "Pass @ #{level}"
Proof::Output.fail "Fail @ #{level}"
Proof::Output.error "Error @ #{level}"
Proof::Output.backtrace "Backtrace @ #{level}"
Proof::Output.details "Details @ #{level} (doesn't print at this level)"

Proof::Output.push_level :debug do
  level = Proof::Output.instance.level
  Proof::Output.details "Details @ #{level}"
end
