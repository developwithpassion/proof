module Proof
  class ProofSpecification
    def initialize(obj_under_test, proof_module, &blk)
      @obj_under_test = obj_under_test
      @proof_module = proof_module
      @blk = blk
    end

    def self.run(obj_under_test, &blk)
      proof_module = ProofResolution.find_proof_module_for(obj_under_test)
      proof = ProofSpecification.new(obj_under_test,proof_module,&blk)
      proof.is_valid
    end

    def is_valid
      @obj_under_test.extend @proof_module
      @obj_under_test.instance_eval &@blk
    end
  end
end
