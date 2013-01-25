module Proof
  class Output
    include Single
    include Setter::Settings
    include ::Output

    level :info

    writer :info, :level => :info

    writer :h1, :level => :info do |text|
      "\n#{text.upcase}\n"
    end

    writer :h2, :level => :info do |text|
      "#{text}\n"
    end

    writer :note, :level => :info do |text|
      "* #{text}"
    end

    writer :pass, :level => :info do |text|
      "Pass: #{text}"
    end

    writer :fail, :level => :info do |text|
      "-> Fail: #{text}"
    end

    writer :error, :level => :warn do |text|
      "Error: #{text}"
    end

    writer :backtrace, :level => :error
    writer :details, :level => :debug
  end
end
