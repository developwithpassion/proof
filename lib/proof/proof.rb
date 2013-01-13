module Proof
  extend self

  def run(description='',&blk)
    proof_block = ProofBlock.new(&blk)
    result =  proof_block.run
    message = result ? "Pass:" : "Fail:"
    message = "#{message} #{description}"
    puts message
  end

  def description
    @description
  end

  def description=(value = nil)
    @description = value 
  end

  def proof_module(obj_under_test)
    mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
    mod.const_get :Proof
  end

  def begin
    ObjectCoreExt.define_prove
  end

  def end
    ObjectCoreExt.undefine_prove
  end
end
