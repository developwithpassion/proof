require_relative '../proofs_init'

include Proof::SketchStyle

Proof::begin


desc 'Exceptions should be output to the console'
item = Object.new

item.prove { raise 'This is an error'}

