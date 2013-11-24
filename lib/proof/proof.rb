module Proof
  def proof(description=nil, &block)
    Proof::Description.current = description
    Proof.start
    yield
    Proof.stop
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
    yield if block_given?
  end

  def section(heading='')
    Proof::Output.h2 heading
    yield if block_given?
  end
  alias :block :section

  def comment(comment)
    Proof::Output.note comment
  end

  def self.start
    CoreExt::Object::Methods.define_prove
  end

  def self.stop
    CoreExt::Object::Methods.undefine_prove
  end
end
