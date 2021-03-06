module Proof
  class Extend
    include Initializer

    initializer :obj_under_test

    def self.into(obj_under_test)
      instance = new obj_under_test
      instance.extend_obj
    end

    def mod
      @mod ||= ([Module, Class].include?(obj_under_test.class) ? obj_under_test : obj_under_test.class)
    end

    def extend_obj
      if extension.nil?
        Output.details "#{mod.name} not extended by #{extension_name}"
        return obj_under_test
      end

      Output.details "Extending #{extension_name} into #{mod.name}"
      Extension.! obj_under_test, extension
    end

    def extension
      return @extension if @extension

      Output.details "#{mod.name} has #{defined ? '' : 'no '}inner Proof"

      return nil unless defined
      
      Output.details "Getting constant #{mod.name}::Proof"
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
