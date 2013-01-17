module Proof
  module Writers
    def disable
      each do |item|
        item.disable
      end
    end
  end
end
