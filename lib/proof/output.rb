module Proof
  class Output
    attr_accessor :pass_logger
    attr_accessor :fail_logger

    def self.instance
      @instance ||= new
    end

    def self.pass(text)
      instance.pass text
    end

    def pass(text)
      @pass_logger.info text
      text
    end

    def self.fail(text)
      instance.fail text
    end

    def fail(text)
      @fail_logger.error text
      text
    end
  end
end
