require 'mixology'

module Proof  
  def start
    def_prove
    if block_given?
      yield
      undef_prove
    end
  end
  module_function :start
  
  def def_prove
    Object.class_eval do
      # def prove(&blk)
      def prove(method=nil, &blk)
        proof_module = self.class.const_get :Proof
        mixin proof_module
        proof = if method
                  send method, &blk
                else
                  instance_eval &blk
                end
        unmix proof_module
        proof
      end
    end
  end
  module_function :def_prove
  
  def undef_prove
    Object.class_eval do
      undef :prove
    end
  end
  module_function :undef_prove
end
