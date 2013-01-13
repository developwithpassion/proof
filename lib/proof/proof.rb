module Proof
  def run(description='',&blk)
    proof_block = ProofBlock.new(&blk)
    result =  proof_block.run
    message = result ? "Pass:" : "Fail:"
    message = "#{message} #{description}"
    puts message
  end
  module_function :run

  def proof_module(obj_under_test)
    mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
    mod.const_get :Proof
  end
  module_function :proof_module
end
