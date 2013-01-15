module Proof
  class ProofResult
    def initialize(method, error = nil)
      @method = method
      @error = error
    end

    def write
    end
  end
  Result = ProofResult
end
