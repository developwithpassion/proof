module Proof
  class Extension
    attr_accessor :obj_under_test

    def self.into(obj_under_test)
      instance = new
      instance.obj_under_test = obj_under_test
      instance.extend_obj_under_test
    end

    def mod
      (obj_under_test.class == Module ? obj_under_test : obj_under_test.class)
    end

    def extend_obj_under_test
      mod = self.mod
      extension = proof_module

      if extension.nil?
        Output.debug "#{mod.name} not extended by #{extension_name}"
        return false
      end

      if obj_under_test.is_a? extension
        Output.debug "#{mod.name} is already extended by #{extension_name}"
        return false
      end

      Output.debug "Extending #{extension_name} into #{mod.name}"
      obj_under_test.extend extension
    end

    def proof_module
      mod = self.mod

      defined = mod.const_defined? :Proof, search_ancestors=false
      Output.debug "#{mod.name} has #{defined ? '' : 'no '}inner Proof"

      return nil unless defined
      
      Output.debug "Getting constant #{mod.name}::Proof"
      mod.const_get :Proof, search_ancestors=false
    end

    def extension_name
      "#{mod.name}::Proof"
    end
  end
end
