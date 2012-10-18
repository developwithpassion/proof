require 'mixology'

module Observance  
  def start
    def_observe
    if block_given?
      yield
      undef_observe
    end
  end
  module_function :start
  
  def def_observe
    Object.class_eval do
      def observe(&blk)
        observance_module = self.class.const_get :Observance
        mixin observance_module
        observed = instance_eval &blk
        unmix observance_module
        observed
      end
    end
  end
  module_function :def_observe
  
  def undef_observe
    Object.class_eval do
      undef :observe
    end
  end
  module_function :undef_observe
end
