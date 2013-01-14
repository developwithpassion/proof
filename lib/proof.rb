require 'proof/proof_result'
require 'proof/proof_execution'
require 'proof/core_ext'
require 'proof/proof'
require 'proof/sketch_style'
require 'proof/output'
require 'proof/configuration'

proofs_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'proofs'))
$LOAD_PATH.unshift proofs_dir unless $LOAD_PATH.include?(proofs_dir)
