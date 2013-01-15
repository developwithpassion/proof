module Proof
  class Result
    def initialize(status, error = nil)
      @status = status
      @error = error
    end

    def write
    end
  end
end
