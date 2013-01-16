module Proof
  class Output
    attr_accessor :info_logger
    attr_accessor :pass_logger
    attr_accessor :fail_logger
    attr_accessor :error_logger
    attr_accessor :backtrace_logger
    attr_accessor :details_logger

    def self.instance
      @instance ||= new
    end

    def self.info(text)
      instance.info text
    end

    def info(text)
      @info_logger.info text
      text
    end

    def self.pass(text)
      instance.pass text
    end

    def pass(text)
      @pass_logger.info "Pass: #{text}"
      text
    end

    def self.fail(text)
      instance.fail text
    end

    def fail(text)
      @fail_logger.error "Fail: #{text}"
      text
    end

    def self.error(text)
      instance.error text
    end

    def error(text)
      @error_logger.debug text
      text
    end

    def self.backtrace(text)
      instance.backtrace text
    end

    def backtrace(text)
      @backtrace_logger.debug text
      text
    end

    def self.details(text)
      instance.details text
    end

    def details(text)
      @details_logger.debug text
      text
    end
  end
end
