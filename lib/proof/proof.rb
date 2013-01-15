module Proof
  extend self

  def proof(description=nil, &block)
    Proof::Description.current = description
    Proof.begin
    yield
    Proof.end
    desc nil
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

  def proof_module(obj_under_test)
    mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class

    defined = mod.const_defined? :Proof, ancestors=false
    Output.debug "#{mod.name}::Proof is #{defined ? '' : 'not '}defined"

    return nil unless defined
    
    Output.debug "Getting constant: #{mod.name}::Proof"
    mod.const_get :Proof
  end
end
