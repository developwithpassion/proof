module Proof
  class ProofItem
    def initialize(&blk)
      @blk = blk
    end

    def run
      def_prove
      result = @blk.call
      undef_prove
      result
    end

    def def_prove
      Object.class_eval do
        def prove(&blk)
          ProofSpecification.run(self,&blk)
        end
      end
    end

    def undef_prove
      Object.class_eval do
        undef :prove
      end
    end
  end
end
