puts RUBY_DESCRIPTION
puts

require_relative '../init.rb'

proof_dir = File.expand_path(File.dirname(__FILE__))

$LOAD_PATH.unshift proof_dir

include Proof
