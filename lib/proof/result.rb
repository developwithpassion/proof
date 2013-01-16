module Proof
  class Result
    attr_reader :description
    attr_reader :status
    attr_reader :error

    def initialize(description, status, error=nil)
      @description = description
      @status = status
      @error = error
    end

    def write
      Output.send output_method, description
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
