require_relative '../proofs_init'

title 'Title Line Spacing'

class String
  module Proof
    def preceded_by_two_new_lines?
      new_lines = ::Proof::Output.new_line 2
      start_with? new_lines
    end
  end
end

def device
  Output::Devices.build_device :string_io
end

def output
  output = Proof::Output.new
end

heading "Title" do
  otp = output
  dvc = device
  otp.push_device dvc

  otp.suspend_devices :stdout do
    otp.h1 'some h1'
  end

  text = dvc.read

  otp.details "Text: <<#{text}>>"

  proof 'Preceded by two new lines' do
    text.prove { preceded_by_two_new_lines? }
  end
end
