module Proof  
  def run(description='',&blk)
    proof_block = ProofBlock.new(&blk)
    result =  proof_block.run
    message = result ? "Pass:" : "Fail:"
    message = "#{message} - #{description}"
    puts message
  end
  module_function :run
end
