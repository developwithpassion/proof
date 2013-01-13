module Proof
  class ProofResolution
    def self.find_proof_module_for(target)
      proof_resolver = target.class == Module ? target : target.class
      proof_resolver.const_get :Proof
    end
  end
end
