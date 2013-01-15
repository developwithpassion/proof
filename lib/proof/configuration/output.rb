require 'logging'

module Proof
  module Configuration
    module Output
      extend self

      def configure
        layout_type = Logging::Layouts::Pattern
        proof_result_layout_options = { :pattern => '%c: %m\n' }
        info_layout_options = { :pattern => '%m\n' }

        info_appender_type = Logging::Appenders::Stdout
        info_appender_options = { :level => :info }

        pass_appender_type = Logging::Appenders::Stdout
        pass_appender_options = { :level => :info }

        fail_appender_type = Logging::Appenders::Stderr
        fail_appender_options = { :level => :error }

        error_appender_type = Logging::Appenders::Stderr
        error_appender_options = { :level => :debug }

        backtrace_appender_type = Logging::Appenders::Stdout
        backtrace_appender_options = { :level => :debug }

        details_appender_type = Logging::Appenders::Stdout
        details_appender_options = { :level => :info }

        proof_layout = layout_type.new(proof_result_layout_options)
        proof_layout_opts = { :layout => proof_layout }

        info_layout = layout_type.new(info_layout_options)
        info_layout_opts = { :layout => info_layout }

        info_appender = info_appender_type.new(
          name = 'info_appender',
          info_layout_opts.merge(info_appender_options)
        )

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

        backtrace_appender = details_appender_type.new(
          name = 'backtrace_appender',
          info_layout_opts.merge(backtrace_appender_options)
        )

        details_appender = details_appender_type.new(
          name = 'details_appender',
          info_layout_opts.merge(details_appender_options)
        )

        output = Proof::Output.instance

        output.info_logger = Logging.logger['Info']
        output.info_logger.add_appenders info_appender

        output.pass_logger = Logging.logger['Pass']
        output.pass_logger.add_appenders pass_appender

        output.fail_logger = Logging.logger['Fail']
        output.fail_logger.add_appenders fail_appender

        output.error_logger = Logging.logger['Error']
        output.error_logger.add_appenders error_appender

        output.backtrace_logger = Logging.logger['Backtrace']
        output.backtrace_logger.add_appenders backtrace_appender

        output.details_logger = Logging.logger['Details']
        output.details_logger.add_appenders details_appender
      end

      configure
    end
  end
end
