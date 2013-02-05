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
      attr_accessor :details_writer

      def configure
        initialize_writers

        set Proof::Output.instance
      end

      def initialize_writers
        root = root_namespace

        # TODO Writers need to be built from the output object that houses them,
        # so that the output object can give the writer its settings, eg: logger_level
        # self.info_writer = ::Output::Writer.build namespace(root, 'Info'), :info
        # self.pass_writer = ::Output::Writer.build namespace(root, 'Pass'), :info
        # self.fail_writer = ::Output::Writer.build namespace(root, 'Fail'), :info
        # self.error_writer = ::Output::Writer.build namespace(root, 'Error'), :warn
        # self.backtrace_writer = ::Output::Writer.build namespace(root, 'Backtrace'), :error
        # self.details_writer = ::Output::Writer.build namespace(root, 'Details'), :debug
      end

      # configure
    end
  end
end
