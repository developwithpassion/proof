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
  end

  def section(heading)
    heading(heading)
    yield if block_given?
    Proof::Output.info ''
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

  module LoadPath
    extend self
    
    def add_dir(caller)
      caller_dir = File.dirname caller
      $LOAD_PATH.unshift caller_dir unless $LOAD_PATH.include?(caller_dir)
    end
  end
end
