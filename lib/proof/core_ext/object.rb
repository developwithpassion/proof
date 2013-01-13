module Proof
  module CoreExt
    module Object
      module Methods
        extend self

        def define_prove
          ::Object.class_eval do
            def prove(&blk)
              obj_under_test = self

              # TODO <-
              # consider making this a separate object or method
              # It can be controlled directly once separated from the need
              # to set up a test
              proof_module = Proof::proof_module(obj_under_test)
              obj_under_test.extend proof_module

              result = obj_under_test.instance_eval &blk
              message = result ? "Pass:" : "Fail:"
              message = "#{message} #{Proof::description}"
              ## ->
              puts message
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
