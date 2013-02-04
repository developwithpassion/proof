module Proof
  class Execution
    include Initializer

    initializer :description, :obj_under_test, :blk

    def self.run(description, obj_under_test, blk)
      instance = new description, obj_under_test, blk
      instance.run
    end

    def run
      error = nil
      begin
        result = obj_under_test.instance_eval &blk
        status = result ? :pass : :fail
      rescue => error
        status = :error
      end
      Proof::Result.new description, status, error
    end
  end
end
