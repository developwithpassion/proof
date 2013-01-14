require 'logging'

module Proof
  module Configuration
    module Output
      extend self

      def configure
        layout_type = Logging::Layouts::Pattern
        proof_result_layout_options = { :pattern => '%c: %m\n' }
        info_layout_options = { :pattern => '%m\n' }

        pass_appender_type = Logging::Appenders::Stdout
        pass_appender_options = { :level => :info }

        fail_appender_type = Logging::Appenders::Stderr
        fail_appender_options = { :level => :error }

        error_appender_type = Logging::Appenders::Stderr
        error_appender_options = { :level => :debug }

        info_appender_type = Logging::Appenders::Stdout
        info_appender_options = { :level => :info }

        proof_layout = layout_type.new(proof_result_layout_options)
        proof_layout_opts = { :layout => proof_layout }

        info_layout = layout_type.new(info_layout_options)
        info_layout_opts = { :layout => info_layout }

        pass_appender = pass_appender_type.new(
          name = 'pass_appender',
          proof_layout_opts.merge(pass_appender_options)
        )

        fail_appender = fail_appender_type.new(
          name = 'fail_appender',
          proof_layout_opts.merge(fail_appender_options)
        )

        error_appender = error_appender_type.new(
          name = 'error_appender',
          proof_layout_opts.merge(error_appender_options)
        )

        info_appender = info_appender_type.new(
          name = 'info_appender',
          info_layout_opts.merge(info_appender_options)
        )

        output = Proof::Output.instance

        output.pass_logger = Logging.logger['Pass']
        output.pass_logger.add_appenders pass_appender

        output.fail_logger = Logging.logger['Fail']
        output.fail_logger.add_appenders fail_appender

        output.error_logger = Logging.logger['Error']
        output.error_logger.add_appenders error_appender

        output.info_logger = Logging.logger['Info']
        output.info_logger.add_appenders info_appender
      end

      configure
    end
  end
end
