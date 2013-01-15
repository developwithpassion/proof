module Proof
  module Extension
    extend self

    def proof_module(obj_under_test)
      mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class

      defined = mod.const_defined? :Proof, ancestors=false
      Output.debug "#{mod.name}::Proof is #{defined ? '' : 'not '}defined"

      return nil unless defined
      
      Output.debug "Getting constant: #{mod.name}::Proof"
      mod.const_get :Proof
    end

  end
end
