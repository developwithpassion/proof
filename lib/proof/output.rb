require 'ostruct'

module Proof
  class Output
    include Single
    include Setter::Settings
    include ::Output

    level :info

    writer :h1, :level => :info do |text|
      prepend :h1, text.upcase
    end

    writer :h2, :level => :info do |text|
      prepend :h2, text
    end

    writer :pass, :level => :info do |text|
      prepend :pass, "Pass: #{text}"
    end

    writer :fail, :level => :info do |text|
      prepend :fail, "-> Fail: #{text}"
    end

    writer :error, :level => :warn do |text|
      prepend :error, "Error: #{text}"
    end

    writer :backtrace, :level => :error do |text|
      prepend :backtrace, text
    end

    writer :details, :level => :debug do |text|
      prepend :details, "! #{text}"
    end

    writer :note, :level => :info do |text|
      prepend :note, "* #{text}"
    end

    writer :info, :level => :info do |text|
      prepend :info, text
    end

    writer :summary, :level => :info do |text|
      prepend :summary, text.upcase
    end

    def prepend(method, text)
      lines = lines(method)
      "#{lines}#{text}"
    end

    def lines(method)
      if [:h1, :summary].include? method
        lines = 2
      elsif [:h2, :details, :note, :info].include? method
        lines = 1
      elsif [:pass, :fail].include? method
        if last_method? :h1, :h2, :error, :backtrace
          lines = 1
        else
          lines = 0
        end
      elsif method == :error
        lines = 1
      elsif method == :backtrace
        unless last_method? :error
          lines = 1
        else
          lines = 0
        end
      else
        lines = 1
      end

      new_line lines
    end

    def new_line(num=1)
      "\n" * num
    end
  end
end
