module Proof  
  def run(description='',&blk)
    proof_item = ProofItem.new(&blk)
    result =  proof_item.run
    message = result ? "Pass:" : "Fail:"
    message = "#{message} - #{description}"
    puts message
  end
  module_function :run
end
