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

              begin
                result = obj_under_test.instance_eval &blk
                method = result ? :pass : :fail
                messsage = Proof::description
              rescue => error
                method = :error
                messsage = "(#{error.class}) \"#{error.message}\" at #{error.backtrace[0]}"
                backtrace = error.backtrace.join("\n")
              end
              Output.send method, messsage

              if method == :error
                Output.info backtrace
              end
            end
          end
        end

        def undefine_prove
          ::Object.class_eval do
            undef :prove
          end
        end

          def proof_module(obj_under_test)
    mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
    mod.const_get :Proof
  end

      end
    end
  end
end
