module Proof
  module CoreExt
    module Object
      module Methods
        extend self

        def define_prove
          ::Object.class_eval do
            def prove(&blk)
              obj_under_test = self

              Proof::Extend.into obj_under_test

              # TODO
              # Proof:Extension.run obj_under_test, blk
              # where .run is a class method that builds the instance using build library              
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
