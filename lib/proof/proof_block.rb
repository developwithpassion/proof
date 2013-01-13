module Proof
  class ProofBlock
    def initialize(&blk)
      @blk = blk
    end

    def run
      Proof::start
      result = @blk.call
      Proof::stop
      result
    end
  end
end
