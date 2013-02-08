require 'stringio'
require 'pathname'

module Proof
  class Suite
    attr_reader :files

    def device
      @device ||= self.class.default_device
    end

    def output
      @output ||= self.class.default_output
    end

    def initialize(files, device = nil, output = nil)
      @files = files
      @device = device
      @output = output
    end

    def self.default_device
      Output::Devices.build_device(:string_io, :name => :suite_results)
    end

    def self.default_output
      Proof::Output.instance
    end

    def self.run(*args)
      device = default_device
      output = default_output

      if args.last.is_a? Hash
        opts = args.pop
        device = opts[:device] || device
        output = opts[:output] || output
      end

      base_dir = File.expand_path(File.dirname(caller[0]))
      file_patterns = flatten(args)
      files = glob(file_patterns, base_dir)

      if files.empty?
        output.summary "!! Suite has no files"
        return :failure
      end

      instance = new files, device, output
      results = instance.run

      Summary.output(results, output)
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
      output.push_device(device) do
        files.each do |file|
          load file
        end
      end

      device.readlines
    end
  end
end
