module Proof
  module Extension
    extend self

    def proof_module(obj_under_test)
      mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
      mod.const_get :Proof
    end

  end
end
