module Wak
  module Package
    class Nginx < Base
      NAME = "nginx"
      CONFIG_PATH = "/usr/local/etc/nginx/nginx.conf"
      AFTER_LINE = "http {"
      CONFIG_LINE = "include #{Dir.home}/.config/wak/sites/*.conf;"

      def initialize
        super(NAME)
      end

      def install!
        super
        configure!
        start!
      end

      def configure!
        config_file.write_config(config, after)
      end

      def config_path
        CONFIG_PATH
      end

      def config
        CONFIG_LINE
      end

      def after
        AFTER_LINE
      end

      def config_file
        @config_file ||= Configuration::File.new(config_path)
      end

    end
  end
end
