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

        self.info_logger = ::Output::Writer.build namespace(root, 'Info')
        self.pass_logger = ::Output::Writer.build namespace(root, 'Pass')
        self.fail_logger = ::Output::Writer.build namespace(root, 'Fail')
        self.error_logger = ::Output::Writer.build namespace(root, 'Error')
        self.backtrace_logger = ::Output::Writer.build namespace(root, 'Backtrace')
        self.details_logger = ::Output::Writer.build namespace(root, 'Details')
      end

      configure
    end
  end
end
