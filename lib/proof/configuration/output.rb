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
        layout = Logging.layouts.pattern(:pattern => '%m\n')
        stdout_appender = Logging::Appenders::Stdout.new('stdout', :layout => layout)

        logger = Logging.logger[root_namespace]
        logger.appenders = stdout_appender
        logger.level = :info

        root = root_namespace
        self.info_logger = Logging.logger[namespace(root, 'Info')]
        self.pass_logger = Logging.logger[namespace(root, 'Pass')]
        self.fail_logger = Logging.logger[namespace(root, 'Fail')]
        self.error_logger = Logging.logger[namespace(root, 'Error')]
        self.backtrace_logger = Logging.logger[namespace(root, 'Backtrace')]
        self.details_logger = Logging.logger[namespace(root, 'Details')]

        set Proof::Output.instance
      end

      configure
    end
  end
end
