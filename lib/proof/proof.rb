module Proof  
  def start(description=nil)
    @@description ||= description
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

  def description=(val)
    @@description = val
  end
  module_function :description=

  def def_prove
    Object.class_eval do
      def prove(&blk)
        proof_module = self.class.const_get :Proof
        extend proof_module
        proven = instance_eval &blk

        msg = proven ? "Pass:" : "Fail:"
        msg = "#{msg} #{Proof.description}"
        puts msg

        Proof.description = nil

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

  module Description
    def desc(text)
      Proof.description = text
    end
  end
end
