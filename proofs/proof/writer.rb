require_relative '../proofs_init'

Proof.begin

def create_writer
  logger = Object.new
  default_level = :info
  
  Writer.new logger,default_level
end

proof 'Initially enabled' do
  writer = create_writer

  writer.prove { enabled? }
end
