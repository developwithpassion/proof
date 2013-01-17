module Proof
  class Writer
    attr_reader :logger
    attr_reader :level
    attr_reader :disabled

    def initialize(logger,level)
      @logger = logger
      @level = level
      @disabled = false
    end

    def disable
      @disabled = true
    end

    def method_missing(method_id,*args,&block)
      logger.send method_id,*args,&block unless disabled
    end
  end
end
