module Proof
  class ProofBlock
    def initialize(&blk)
      @blk = blk
    end

    def run
      ObjectCoreExt.def_prove
      result = @blk.call
      ObjectCoreExt.undef_prove
      result
    end
  end
end
