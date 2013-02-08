require 'ostruct'

module Proof
  class Output
    include Single
    include Setter::Settings
    include ::Output

    def record_last_write(method, message)
      @last_write = OpenStruct.new :method => method, :message => message
    end

    def last_write
      @last_write
    end

    level :info

    def new_line(num=1)
      "\n" * num
    end

    def prepend_new_line(text, num=1)
      new_lines = new_line(num)
      "#{new_lines}#{text}"
    end

    def prepend_line_level_new_line(text)
      prepend_new_line text
    end

    def self.message(method, text)
      if method == :pass || method == :error
        return "#{method.capitalize}: #{text}"
      elsif method == :fail
        return "-> Fail: #{text}"
      else
        return text
      end
    end

    def write(method, message)
      super method, message
      record_last_write method, message
    end

    writer :h1, :level => :info do |text|
      prepend_new_line text.upcase, 2
    end

    writer :h2, :level => :info do |text|
      prepend_new_line text, 1
    end

    writer :pass, :level => :info do |text|
      prepend_line_level_new_line message(:pass, text)
    end

    writer :fail, :level => :info do |text|
      prepend_line_level_new_line message(:fail, text)
    end

    writer :error, :level => :warn do |text|
      prepend_line_level_new_line message(:error, text)
    end

    writer :backtrace, :level => :error

    writer :details, :level => :debug

    writer :note, :level => :info do |text|
      "* #{text}"
    end

    writer :info, :level => :info

    writer :summary, :level => :info do |text|
      "\n#{text.upcase}\n"
    end
  end
end
