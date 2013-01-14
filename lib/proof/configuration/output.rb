module Proof
  module Configuration
    module Output
      extend self

      def configure
        layout_type = Logging::Layouts::Pattern
        layout_options = { :pattern => '%c: %m\n' }

        pass_appender_type = Logging::Appenders::Stdout
        pass_appender_options = { :level => :info }

        fail_appender_type = Logging::Appenders::Stderr
        fail_appender_options = { :level => :error }


        layout = layout_type.new(layout_options)
        layout_opts = { :layout => layout }

        pass_appender = pass_appender_type.new(
          name = 'pass_appender',
          layout_opts.merge(pass_appender_options)
        )

        fail_appender = fail_appender_type.new(
          name = 'fail_appender',
          layout_opts.merge(fail_appender_options)
        )

        output = Proof::Output.instance

        output.pass_logger = Logging.logger['Pass']
        output.pass_logger.add_appenders pass_appender

        output.fail_logger = Logging.logger['Fail']
        output.fail_logger.add_appenders fail_appender
      end

      configure
    end
  end
end
