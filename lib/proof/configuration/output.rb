require 'logging'

module Proof
  module Configuration
    module Output
      extend self

      def configure
        Logging.appenders.stdout(
          :layout => Logging.layouts.pattern(:pattern => '%m\n')
        )

        Logging.logger.root.level = :info
        Logging.logger.root.appenders = Logging.appenders.stdout

        output = Proof::Output

        output.info_logger = Logging.logger['Info']
        output.pass_logger = Logging.logger['Pass']
        output.fail_logger = Logging.logger['Fail']
        output.error_logger = Logging.logger['Error']
        output.backtrace_logger = Logging.logger['Backtrace']
        output.details_logger = Logging.logger['details']
      end

      configure
    end
  end
end
