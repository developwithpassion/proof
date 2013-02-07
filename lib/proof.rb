require 'logging'
require 'single'
require 'setter'
require 'output'
require 'initializer'

require 'proof/namespace'
require 'proof/description'
require 'proof/extend'
require 'proof/result'
require 'proof/execution'
require 'proof/error'
require 'proof/core_ext'
require 'proof/proof'
require 'proof/output'
require 'proof/suite'
require 'proof/summary'

Proof::LoadPath.add_dir caller[0]
