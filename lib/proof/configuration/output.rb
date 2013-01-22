module Proof
  module Configuration
    class Output
      include Single
      include Setter
      include Proof::Namespace

      attr_accessor :info_writer
      attr_accessor :pass_writer
      attr_accessor :fail_writer
      attr_accessor :error_writer
      attr_accessor :backtrace_writer
      attr_accessor :details_writer

      def configure
        initialize_root_namespace_logger
        initialize_writers

        set Proof::Output.instance
      end

      def initialize_root_namespace_logger
        layout = Logging.layouts.pattern(:pattern => '%m\n')
        stdout_appender = Logging::Appenders::Stdout.new('stdout', :layout => layout)

        logger = Logging.logger[root_namespace]
        logger.appenders = stdout_appender
        logger.level = :debug
      end

      def initialize_writers
        root = root_namespace

        self.info_writer = ::Output::Writer.build namespace(root, 'Info'), :info
        self.pass_writer = ::Output::Writer.build namespace(root, 'Pass'), :info
        self.fail_writer = ::Output::Writer.build namespace(root, 'Fail'), :info
        self.error_writer = ::Output::Writer.build namespace(root, 'Error'), :warn
        self.backtrace_writer = ::Output::Writer.build namespace(root, 'Backtrace'), :error
        self.details_writer = ::Output::Writer.build namespace(root, 'Details'), :debug
      end

      configure
    end
  end
end
