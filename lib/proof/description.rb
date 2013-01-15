module Proof
  class Description
    def current
      @current ||= ''
    end
    
    def self.current=(val)
      @current = val
    end
  end
end
