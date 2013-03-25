require_relative '../proofs_init'

title 'Output Demo'

Proof::Output.push_level :debug do
  level = Proof::Output.instance.level

  Proof::Output.h1 "h1 @ #{level}"

  Proof::Output.h2 "h2 @ #{level}"

  Proof::Output.pass "Pass @ #{level}"
  Proof::Output.fail "Fail @ #{level}"
  Proof::Output.error "Error @ #{level}"
  Proof::Output.backtrace "Backtrace @ #{level}"

  Proof::Output.details "Details @ #{level}"

  Proof::Output.note "Note @ #{level}"
  Proof::Output.info "Info @ #{level}"
  Proof::Output.raw "Raw @ #{level}"

  Proof::Output.summary "Summary @ #{level}"
end
