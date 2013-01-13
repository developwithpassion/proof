module Proof
  class ProofModule
    def self.get(obj_under_test)
      mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
      mod.const_get :Proof
    end
  end
end
