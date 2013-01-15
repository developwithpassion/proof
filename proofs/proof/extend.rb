require_relative '../proofs_init'

class SomeObjectUnderTest
  module Proof
    def extended?
      true
    end
  end
end

proof 'Extends the object under test with the inner proof module' do
  some_object_under_test = SomeObjectUnderTest.new

  extender = Proof::Extend.new(some_object_under_test)
  extender.extend_obj

  Object.new.prove { some_object_under_test.extended? }
end


proof 'Objects under test without an inner proof module can still be proven' do
  some_object_under_test = Object.new

  extender = Proof::Extend.new(some_object_under_test)
  extender.extend_obj

  some_object_under_test.prove { true }
end
