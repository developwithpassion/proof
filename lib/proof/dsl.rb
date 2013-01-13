module Proof
  module DSL
    def proof(description = '',&block)
      Proof.run(description,&block)
    end
  end
end
include Proof::DSL
