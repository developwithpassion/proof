require_relative '../proofs_init'

title 'Exit Status'

def suite
  Proof::Suite
end

def run_with_suite_results_suspended(file, attach_probe = false)
  result = nil
  probe = Output::Devices.build_device(:string_io, :name => :probe)
  active_device = Proof::Output.summary_writer.device(:suite_results)
  output = Proof::Output.new
  output.push_device active_device
  output.push_device probe if attach_probe
  result = suite.run file, :output => output, :device => probe
end

Proof::Output.suspend_devices :stdout do
  proof 'A suite with no files is a failure' do
    exit_status = run_with_suite_results_suspended 'some_file_pattern', attach_probe = true
    exit_status.prove { self == :failure }
  end

  proof 'A suite with any failures is a failure' do
    exit_status = run_with_suite_results_suspended 'example_proof_files/fails.rb'
    exit_status.prove { self == :failure }
  end

  proof 'A suite with only passes is a success' do
    exit_status = run_with_suite_results_suspended 'example_proof_files/passes.rb'
    exit_status.prove { self == :success }
  end
end
