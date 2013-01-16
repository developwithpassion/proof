module Proof
  module Configuration
    class Output
      include Single
      include Setter

      attr_accessor :info_logger
      attr_accessor :pass_logger
      attr_accessor :fail_logger
      attr_accessor :error_logger
      attr_accessor :backtrace_logger
      attr_accessor :details_logger

      def configure
        Logging.appenders.stdout(
          :layout => Logging.layouts.pattern(:pattern => '%m\n')
        )

        Logging.logger.root.level = :info
        Logging.logger.root.appenders = Logging.appenders.stdout

        self.info_logger = Logging.logger['Info']
        self.pass_logger = Logging.logger['Pass']
        self.fail_logger = Logging.logger['Fail']
        self.error_logger = Logging.logger['Error']
        self.backtrace_logger = Logging.logger['Backtrace']
        self.details_logger = Logging.logger['details']

        set Proof::Output.instance
      end

      configure
    end
  end
end
