module Proof
  class Output
    include Single
    include Setter::Settings
    include WriterCreation

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

    # - These generate "#{logger_name}_logger" settings
    # - The :level option is the level set on the logger,
    # and it's the "threshold" for enabling the logger to write
    # - Each call to the "logger" macro records the logger info
    # in the class's list of loggers, which is used for operations
    # that operate on all loggers (eg: output.level = :debug, output.enable_loggers, output.disable)

    writer :info, :level => :info

    writer :pass, :level => :info do |text|
      "Pass: #{text}"
    end

    writer :fail, :level => :info do |text|
      "Fail: #{text}"
    end

    writer :error, :level => :warn do |text|
      "Error: #{text}"
    end

    writer :backtrace, :level => :error
    writer :details, :level => :debug


    def write(method, description)
      send method, description
    end


    def self.disable
      writers.disable
    end
  end
end
