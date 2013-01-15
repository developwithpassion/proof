module Proof
  def proof(description = '',&block)
    desc description
    Proof.begin
    yield
    Proof.end
    desc nil
  end

  def desc(description = '')
    Proof.description = description
  end

  def comment(comment='')
    Output.info comment
  end

  def heading(heading='')
    Output.info "\n#{heading}"
  end






  def description
    @description
  end

  def description=(value = nil)
    @description = value 
  end

  def begin
    CoreExt::Object::Methods.define_prove
  end

  def end
    CoreExt::Object::Methods.undefine_prove
  end

  def proof_module(obj_under_test)
    mod = obj_under_test.class == Module ? obj_under_test : obj_under_test.class
    mod.const_get :Proof
  end
end
