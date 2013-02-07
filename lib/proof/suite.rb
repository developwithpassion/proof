require 'stringio'
require 'pathname'

module Proof
  class Suite
    include Initializer

    initializer :files

    def self.run(*args)
      base_dir = File.expand_path(File.dirname(caller[0]))
      file_patterns = flatten(args)
      files = glob(file_patterns, base_dir)

      if files.empty?
        ::Proof::Output.summary "!! Suite has no files"
        return :failure
      end

      instance = new files

      results = instance.run

      Summary.output(results)
    end

    def self.glob(patterns, base_dir)
      files = []
      patterns.each do |pattern|
        pattern = Pathname.new(pattern).absolute? ? pattern : File.join(base_dir, pattern)
        files.concat Dir.glob(pattern)
      end
      files
    end

    def self.flatten(args)
      files = []
      args.each do |pattern|
        files.concat pattern.is_a?(Array) ? pattern : [pattern]
      end
      files
    end

    def run
      appender = Output.push_device(:string_io) do
        files.each do |file|
          load file
        end
      end

      appender.readlines
    end
  end
end
