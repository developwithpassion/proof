require 'single'

require 'proof/description'
require 'proof/extend'
require 'proof/result'
require 'proof/execution'
require 'proof/error'
require 'proof/core_ext'
require 'proof/proof'
require 'proof/output'
require 'proof/configuration'

proofs_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'proofs'))
$LOAD_PATH.unshift proofs_dir unless $LOAD_PATH.include?(proofs_dir)
