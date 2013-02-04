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
              result = Proof::Execution.run Description.current, obj_under_test, blk
              Events::Event.publish(result.status, result)
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
