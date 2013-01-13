module Proof
  module ObjectCoreExt
    extend self

    def define_prove
      Object.class_eval do
        def prove(&blk)
          obj_under_test = self

          proof_module = Proof::proof_module(obj_under_test)
          obj_under_test.extend proof_module

          obj_under_test.instance_eval &blk
        end
      end
    end

    def undefine_prove
      Object.class_eval do
        undef :prove
      end
    end
  end
end
