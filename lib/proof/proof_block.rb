module Proof
  class ProofBlock
    def initialize(&blk)
      @blk = blk
    end

    def run
      Proof::begin
      result = @blk.call
      Proof::end
      result
    end
  end
end
