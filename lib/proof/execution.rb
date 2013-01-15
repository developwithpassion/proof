module Proof
  class Execution
    attr_reader :obj_under_test
    attr_reader :blk

    def self.run(obj_under_test, blk)
      instance = new obj_under_test, blk
      instance.run
    end

    def initialize(obj_under_test, blk)
      @obj_under_test = obj_under_test
      @blk = blk
    end

    def run
      error = nil
      begin
        result = obj_under_test.instance_eval &blk
        status = result ? :pass : :fail
      rescue => error
        status = :error
      end
      Proof::Result.new status, error
    end
  end
end
