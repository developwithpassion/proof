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

    def prepend(num, text)
      new_lines = new_line(num)
      "#{new_lines}#{text}"
    end

    def write(method, message)
      super method, message
      record_last_write method, message
    end

    writer :h1, :level => :info do |text|
      prepend 2, text.upcase
    end

    writer :h2, :level => :info do |text|
      prepend 1, text
    end

    writer :pass, :level => :info do |text|
      prepend 1, "Pass: #{text}"
    end

    writer :fail, :level => :info do |text|
      prepend 1, "-> Fail: #{text}"
    end

    writer :error, :level => :warn do |text|
      prepend 1, "Error: #{text}"
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
