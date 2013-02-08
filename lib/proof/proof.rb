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

  def title(title)
    Proof::Output.h1 title
  end

  def heading(heading)
    Proof::Output.h2 heading
    if block_given?
      yield
      # Proof::Output.info ''
    end
  end

  def section(heading=nil)
    heading(heading) if heading
    yield if block_given?
    # Proof::Output.info ''
  end

  def comment(comment)
    Proof::Output.note comment
  end

  def begin
    CoreExt::Object::Methods.define_prove
  end

  def end
    CoreExt::Object::Methods.undefine_prove
  end
end
