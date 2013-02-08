require_relative 'proofs_init'

files = Dir.glob("proof/**/*.rb")
files.reject! { |item| /passes\.rb/ =~ item }
files.reject! { |item| /fails\.rb/ =~ item }

Proof::Suite.run files
# Proof::Suite.run "proof/error_output.rb"
# Proof::Suite.run "proof/errors.rb" - 1 pass
# Proof::Suite.run "proof/execution.rb" - 3 pass
# Proof::Suite.run "proof/exit_status.rb" - 3 actual passes (4 because the file is running)
# Proof::Suite.run "proof/extend.rb" - 2 passes
# Proof::Suite.run "proof/line_spacing_for_heading.rb" - 2 passes
# Proof::Suite.run "proof/line_spacing_for_line_level_methods.rb" - 4 passes
# Proof::Suite.run "proof/line_spacing_for_title.rb" - 1 pass
# Proof::Suite.run "proof/proof.rb" - 2 passes
# Proof::Suite.run "proof/suite.rb" - 2 passes
