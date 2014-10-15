require 'fileutils'
module Wak
  module Setup
    module Package
      class Nginx < Base
        NAME = "nginx"
        CONFIG_PATH = "/usr/local/etc/nginx/nginx.conf"
        AFTER_LINE = "http {"
        SITES_DIR = "#{Dir.home}/.config/wak/sites"
        CONFIG_LINE = "include %s/*.conf;"

        def initialize
          super(NAME)
        end

        def install!
          super do
            configure! unless config_file.has_config?(config)
            create_sites_dir! unless sites_dir_exists?
          end
        end

        def configure!
          config_file.write_config(config, after)
        end

        def config_path
          CONFIG_PATH
        end

        def config
          CONFIG_LINE % [sites_dir]
        end

        def after
          AFTER_LINE
        end

        def sites_dir
          SITES_DIR
        end

        def sites_dir_exists?
          Dir.exists?(sites_dir)
        end

        def create_sites_dir!
          FileUtils.mkdir_p(sites_dir)
        end

        def config_file
          @config_file ||= Configuration::File.new(config_path)
        end

      end
    end
  end
end
