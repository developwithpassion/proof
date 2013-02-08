require_relative '../proofs_init'

title 'Line Spacing Before Line Level Writes'

class String
  module Proof
    def line_level_preceded_by_two_new_lines?(line, block)
      new_lines = ::Proof::Output.new_line 2
      downcase.include? "#{block}#{new_lines}#{line}".downcase
    end
  end
end

def device
  Output::Devices.build_device :string_io
end

def output
  output = Proof::Output.new
end

def block_level_methods
  [:h1, :h2]
end

def line_level_methods
  # [:pass, :fail, :error, :backtrace, :details, :note, :info]
  [:pass, :error]
end

block do
  combined = block_level_methods.product line_level_methods

  combined.each do |combination|
    otp = output
    dvc = device
    otp.push_device dvc

    block_level_method, line_level_method = combination

    heading "#{line_level_method.capitalize} Preceded By #{block_level_method.capitalize}" do

      block = "some #{block_level_method}"
      line = "some #{line_level_method}"

      otp.suspend_devices :stdout do
        otp.write block_level_method, block
        otp.write line_level_method, line
      end

      text = dvc.read

      proof "#{line_level_method} is preceded by two new lines" do
        line = "#{line_level_method.capitalize}: #{line}"
        text.prove { line_level_preceded_by_two_new_lines? line, block }
      end
    end
  end
end
