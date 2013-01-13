module Proof
  module DSL
    def proof(description = '',&block)
      Proof.run(description,&block)
    end

    def desc(description = '')
      Proof::description = description
    end
  end
end
