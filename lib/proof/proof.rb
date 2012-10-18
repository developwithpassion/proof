module Proof  
  def start(description="")
    @@description = description
    if block_given?
      def_prove
      yield
      undef_prove
    end
  end
  module_function :start

  def description
    @@description
  end
  module_function :description

  def def_prove
    Object.class_eval do
      def prove(&blk)
        proof_module = self.class.const_get :Proof
        extend proof_module
        proven = instance_eval &blk

        msg = proven ? "Pass:" : "Fail:"
        msg = "#{msg} #{Proof.description}"
        puts msg

        proven
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
