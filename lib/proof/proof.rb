module Proof  
  def start
    if block_given?
      def_prove
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
        extend proof_module
        proof = if method
                  send method, &blk
                else
                  instance_eval &blk
                end
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
