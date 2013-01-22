require 'logging'
require 'single'
require 'setter'
require 'output'

require 'proof/namespace'
require 'proof/description'
require 'proof/extend'
require 'proof/result'
require 'proof/execution'
require 'proof/error'
require 'proof/core_ext'
require 'proof/proof'
require 'proof/output'
require 'proof/configuration'

Proof::LoadPath.add_dir caller[0]
