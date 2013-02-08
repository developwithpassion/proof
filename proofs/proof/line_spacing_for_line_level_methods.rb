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
  block_level_methods.each do |block_level_method|
    otp = output
    dvc = device

    otp.push_device(dvc) do
      heading "Pass Preceded By #{block_level_method.capitalize}" do

        some_block = "some #{block_level_method}"
        some_line = "some pass"

        otp.suspend_devices :stdout do
          otp.write block_level_method, some_block
          otp.pass some_line
        end

        text = dvc.read

        proof "Pass is preceded by two new lines" do
          line = "Pass: #{some_line}"
          text.prove { line_level_preceded_by_two_new_lines? line, block }
        end
      end
    end
  end
end
