module Proof
  module Extension
    extend self

    def into(obj_under_test)
      mod = (obj_under_test.class == Module ? obj_under_test : obj_under_test.class)

      extension = proof_module(mod)

      if extension.nil?
        Output.debug "#{mod.name} not extended by #{extension_name(mod)}"
        return false
      end

      if obj_under_test.is_a? extension
        Output.debug "#{mod.name} is already extended by #{extension_name(mod)}"
        return false
      end

      Output.debug "Extending #{extension_name(mod)} into #{mod.name}"
      obj_under_test.extend extension
    end

    def proof_module(mod)
      defined = mod.const_defined? :Proof, search_ancestors=false
      Output.debug "#{mod.name} has #{defined ? '' : 'no '}inner Proof"

      return nil unless defined
      
      Output.debug "Getting constant #{mod.name}::Proof"
      mod.const_get :Proof, search_ancestors=false
    end

    def extension_name(mod)
      "#{mod.name}::Proof"
    end
  end
end
