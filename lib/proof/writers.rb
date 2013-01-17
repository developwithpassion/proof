module Proof
  module Writers
    def disable
      each do |item|
        item.disable
      end
    end

    def level=(new_level)
      each do |item|
        item.level = new_level
      end
    end
  end
end
