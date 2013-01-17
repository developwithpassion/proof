module Proof
  class Writer
    attr_reader :logger
    attr_reader :default_level
    attr_reader :enabled

    def initialize(logger, default_level)
      @logger = logger
      @default_level = default_level
      enable
    end

    def disable
      @enabled = false
    end

    def enable
      @enabled = true
    end

    def enabled?
      @enabled
    end

    def write(logging_method, message)
      logger.send logging_method, message if enabled?
    end
  end
end
