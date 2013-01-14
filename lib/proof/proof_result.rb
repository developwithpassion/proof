module Proof
  class ProofResult
    def initialize(method, error = nil)
      @method = method
      @error = error
    end
  end
end
