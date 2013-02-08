require_relative '../proofs_init'

title 'Heading Line Spacing'

class String
  module Proof
    def preceded_by_one_new_line?
      new_line = ::Proof::Output.new_line
      start_with? new_line
    end
  end
end

def device
  Output::Devices.build_device :string_io
end

def output
  output = Proof::Output.new
end

heading "Heading" do
  otp = output
  dvc = device
  otp.push_device dvc

  otp.suspend_devices :stdout do
    otp.h2 'some h2'
  end

  text = dvc.read

  otp.details "Text: <<#{text}>>"

  proof 'Preceded by one new lines' do
    text.prove { preceded_by_one_new_line? }
  end
end
