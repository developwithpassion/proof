module Proof
  def proof(description=nil, &block)
    Proof::Description.current = description
    Proof.begin
    yield
    Proof.end
    Proof::Description.current = nil
  end

  def desc(description)
    Proof::Description.current = description
  end

  def comment(comment)
    Output.info comment
  end

  def heading(heading)
    Output.info "\n#{heading}"
  end

  def begin
    CoreExt::Object::Methods.define_prove
  end

  def end
    CoreExt::Object::Methods.undefine_prove
  end
end
