module Proof
  module CoreExt
    module Object
      module Methods
        extend self

        def define_prove
          ::Object.class_eval do
            def prove(&blk)
              obj_under_test = self
              proof_module = Proof::proof_module(obj_under_test)
              obj_under_test.extend proof_module

              execution = ProofExecution.new
              execution.obj_under_test = obj_under_test
              execution.blk = blk

              result = execution.run
              result.write
            end
          end
        end

        def undefine_prove
          ::Object.class_eval do
            undef :prove
          end
        end
      end
    end
  end
end
