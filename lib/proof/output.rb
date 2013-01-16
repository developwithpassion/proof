require 'setter'

module Proof
  class Output
    include Single
    include Setter::Settings

    # TODO settings
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

    setting :info_logger
    setting :pass_logger
    setting :fail_logger
    setting :error_logger
    setting :backtrace_logger
    setting :details_logger

    def write(method, description)
      send method, description
    end

    def info(text)
      info_logger.info text
      text
    end

    def pass(text)
      pass_logger.info "Pass: #{text}"
      text
    end

    def fail(text)
      fail_logger.info "Fail: #{text}"
      text
    end

    def error(text)
      error_logger.warn "Error: #{text}"
      text
    end

    def backtrace(text)
      backtrace_logger.error text
      text
    end

    def details(text)
      details_logger.debug text
      text
    end
  end
end
