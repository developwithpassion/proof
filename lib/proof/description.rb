module Proof
  class Description
    def current
      @current ||= ''
    end
    
    def self.current=(val)
      @current = val
    end

    def self.current
      @current
    end
  end
end
