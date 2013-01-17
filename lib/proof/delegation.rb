module Proof
  module Delegation
    def self.included(base)
      base.extend ClassMethods
    end
  end

  module Dispatch
    extend self
    def singular(&item_resolution_block)
      Proc.new do |method_id, *args, &blk|
        target = item_resolution_block.call
        target.send method_id, *args,&blk  
      end
    end

    def broadcast(&items_resolution)
      Proc.new do|method_id, *args, &blk|
        items_resolution.call.each do|item|
          target = singular { item }
          target.call method_id, *args, &blk
        end
      end
    end
  end

  module ClassMethods
    def delegate(*method_ids, &item_resolution_block)
      dispatch *method_ids, Dispatch.singular(&item_resolution_block)
    end

    def broadcast(*method_ids, &iterator_resolution_block)
      dispatch *method_ids, Dispatch.broadcast(&iterator_resolution_block)
    end

    def dispatch(*method_ids, dispatch)
      method_ids.each do |method_id|
        define_method method_id do|*args, &blk|
          dispatch.call method_id, *args,&blk
        end
      end
    end

  end
end
