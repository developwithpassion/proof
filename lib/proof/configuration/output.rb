module Proof
  module Configuration
    class Output
      include Single
      include Setter
      include Proof::Namespace

      attr_accessor :info_logger
      attr_accessor :pass_logger
      attr_accessor :fail_logger
      attr_accessor :error_logger
      attr_accessor :backtrace_logger
      attr_accessor :details_logger

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

        self.info_logger = create_writer namespace(root, 'Info')
        self.pass_logger = create_writer namespace(root, 'Pass')
        self.fail_logger = create_writer namespace(root, 'Fail')
        self.error_logger = create_writer namespace(root, 'Error')
        self.backtrace_logger = create_writer namespace(root, 'Backtrace')
        self.details_logger = create_writer namespace(root, 'Details')
      end

      def create_writer(writer_name, level = :debug)
        logger = Logging.logger[writer_name]
        writer = Writer.new(logger, level)
      end
      configure
    end
  end
end
