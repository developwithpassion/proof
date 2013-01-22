module Proof
  class Output
    include Single
    include Setter::Settings
    include ::Output

    level :info

    writer :info, :level => :info

    writer :pass, :level => :info do |text|
      "Pass: #{text}"
    end

    writer :fail, :level => :info do |text|
      "Fail: #{text}"
    end

    writer :error, :level => :warn do |text|
      "Error: #{text}"
    end

    writer :backtrace, :level => :error
    writer :details, :level => :debug
  end
end
