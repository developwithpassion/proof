module Proof
  class Extend
    attr_reader :obj_under_test

    def self.into(obj_under_test)
      instance = new obj_under_test
      instance.extend_obj
    end

    def initialize(obj_under_test)
      @obj_under_test = obj_under_test
    end

    def mod
      @mod ||= (obj_under_test.class == Module ? obj_under_test : obj_under_test.class)
    end

    def extend_obj
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

      true
    end

    def extension
      return @extension if @extension

      Output.debug "#{mod.name} has #{defined ? '' : 'no '}inner Proof"
      return nil unless defined
      
      Output.debug "Getting constant #{mod.name}::Proof"
      @extension ||= mod.const_get :Proof, search_ancestors=false
    end

    def defined
      @defined ||= mod.const_defined? :Proof, search_ancestors=false
    end

    def extension_name
      "#{mod.name}::Proof"
    end
  end
end
