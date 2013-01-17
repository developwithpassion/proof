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

    # - These generate "#{logger_name}_logger" settings
    # - The :level option is the level set on the logger,
    # and it's the "threshold" for enabling the logger to write
    # - Each call to the "logger" macro records the logger info
    # in the class's list of loggers, which is used for operations
    # that operate on all loggers (eg: output.level = :debug, output.enable_loggers, output.disable)
    def generate_setting(setting_name)
      self.class.setting setting_name
    end

    def logger(name,options = {},&transform_block)
      transform = transform_block if block_given?
      transform = transform || ->(message){ message } 
      level = options.fetch(:level,:info)
      logger_accessor_name = "#{name}_logger"

      generate_setting logger_accessor_name

      self.class.send :define_method,name do |log_message|
        log_message = transform.call log_message
        logger = send logger_accessor_name
        logger.send level, log_message
        log_message
      end
    end

    logger :info, :level => :info

    logger :pass, :level => :info do |text|
      "Pass: #{text}"
    end

    logger :fail, :level => :info do |text|
      "Fail: #{text}"
    end

    logger :error, :level => :warn do |text|
      "Error: #{text}"
    end

    logger :backtrace, :level => :error
    logger :details, :level => :debug


    def write(method, description)
      send method, description
    end

  end
end
