module Proof
  class Result
    attr_reader :status
    attr_reader :error

    def initialize(status, error=nil)
      @status = status
      @error = error
    end

    def write
      Output.send output_method, "#{Description.current}"
      Error.output error if status == :error
    end

    def output_method
      if status == :error
        return :fail
      end
      return status
    end
  end
end
