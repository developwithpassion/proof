module Proof
  module SketchStyle
    def proof(description = '',&block)
      desc description
      Proof.begin
      yield
      Proof.end
      desc nil
    end

    def desc(description = '')
      Proof::description = description
    end

    # TODO
    # Use Output.write
    def comment(comment='')
      Output.info comment
    end

    def heading(heading='')
      Output.info "\n#{heading}"
    end
  end
end
