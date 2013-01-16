module Proof
  class Output

    # TODO settings
    # TODO single
    # TODO def level=(level:Symbol) (sets all logger levels)
    # TODO def levels=(levels:Hash) (sets logger levels specified in hash)
    # TODO def default_levels (sets logger levels to default levels)
    # TODO def activate(logger_names:[Symbol] or Symbol) (sets loggers to level where it writes)
    # TODO def deactivate(logger_names:[Symbol] or Symbol) (sets logger to level where it doesn't write)

    # This turns on all loggers
    # output.info_logger.level = :info
    # output.pass_logger.level = :info
    # output.fail_logger.level = :info
    # output.error_logger.level = :warn
    # output.backtrace_logger.level = :error
    # output.details_logger.level = :debug        

    attr_accessor :info_logger
    attr_accessor :pass_logger
    attr_accessor :fail_logger
    attr_accessor :error_logger
    attr_accessor :backtrace_logger
    attr_accessor :details_logger

    def self.instance
      @instance ||= new
    end

    def self.write(method, description)
      instance.write method, description
    end

    def write(method, description)
      send method, description
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
      @fail_logger.info "Fail: #{text}"
      text
    end

    def self.error(text)
      instance.error text
    end

    def error(text)
      @error_logger.warn text
      text
    end

    def self.backtrace(text)
      instance.backtrace text
    end

    def backtrace(text)
      @backtrace_logger.error text
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
