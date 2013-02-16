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
    end
  end

  def section(heading=nil)
    yield if block_given?
  end
  alias :block :section

  def comment(comment)
    Proof::Output.note comment
  end

  def self.begin
    CoreExt::Object::Methods.define_prove
  end

  def self.end
    CoreExt::Object::Methods.undefine_prove
  end
end
