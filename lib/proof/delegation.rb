module Proof
  module Delegation
    def self.included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def delegates(*method_ids, &item_resolution_block)
      target = item_resolution_block

      method_ids.each do |method_id|
        define_method method_id do|*args,&blk|
          item_resolution_block.call.send method_id, *args, &blk
        end
      end
    end
  end
end
