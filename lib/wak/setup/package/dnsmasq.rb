module Wak
  module Setup
    module Package
      class Dnsmasq < Base
        NAME = "dnsmasq"
        CONFIG_PATH = "/usr/local/etc/dnsmasq.conf"
        CONFIG_LINE = "address=/.dev/127.0.0.1"

        def initialize
          super(NAME)
        end

        def install!
          super do
            configure!
          end
        end

        def configure!
          config_file.write_config(config)
        end

        def config
          CONFIG_LINE
        end

        def config_path
          CONFIG_PATH
        end

        def config_file
          @config_file ||= Configuration::File.new(config_path)
        end

      end
    end
  end
end
