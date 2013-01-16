module Proof
  module Namespace
    def root_namespace
       self.class.name.split('::').first
    end

    def namespace(*namespace)
      namespace.join('::')
    end
  end
end
