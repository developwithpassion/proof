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
                backtrace = error.backtrace
                line_detail = backtrace[0].gsub(/.*\/proofs\/proof\/(.*\.rb.*)/,'\1')
                messsage = "(#{error.class}) \"#{error.message}\" at #{line_detail}"
              end
              Output.send method, messsage

              if method == :error
                backtrace.reject! {|l| l =~ /proof\/lib\/proof/ }
                Output.debug backtrace.join("\n")
              end
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
