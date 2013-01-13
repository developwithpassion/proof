module Proof
  module DSL
    def proof(description = '',&block)
      desc description
      Proof.begin
      yield
      Proof.end
      desc nil
    end

    def desc(description = '')
      Proof::description = description
    end
  end
end
