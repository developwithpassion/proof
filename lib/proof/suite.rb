require 'stringio'
require 'pathname'

module Proof
  class Suite
    attr_reader :files

    def device
      @device ||= self.class.default_device
    end

    def initialize(files, device = nil)
      @files = files
      @device = device
    end

    def self.default_device
      Output::Devices.build_device(:string_io, :name => :suite_results)
    end

    def self.run(*args, device)
      unless device.is_a? Logging::Appender
        args.push device
        device = default_device
      end

      base_dir = File.expand_path(File.dirname(caller[0]))
      file_patterns = flatten(args)
      files = glob(file_patterns, base_dir)

      if files.empty?
        ::Proof::Output.summary "!! Suite has no files"
        return :failure
      end

      instance = new files, device
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
      Output.push_device(device) do
        files.each do |file|
          load file
        end
      end

      device.readlines
    end
  end
end
