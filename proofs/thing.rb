class Thing
  def some_method
    puts 'Hi from some method'
  end

  def some_other_method
    puts 'This method is not called'
  end

  module Proof
    def some_method
      super
      1 == 1
    end
  end 
end
