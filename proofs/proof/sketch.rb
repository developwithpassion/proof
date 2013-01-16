module Foo
  module Bar
    class Baz
    end
  end
end

b = Foo::Bar::Baz.new
p b.class.name.split('::').first
