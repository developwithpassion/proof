module Proof
  class Result
    include Initializer

    initializer :description, :status, :error

    def write
      Output.write output_method, description
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
