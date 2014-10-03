require "fileutils"
module Wak
  module Setup
    class DnsConfigurator
      include Wak::Utils::FileUtils
      include Wak::Utils::Runner

      RESOLVER_PATH = "/etc/resolver/dev"
      CONFIG = "nameserver 127.0.0.1"

      def initialize
        create_directory! unless Dir.exists?(dirname)
        create_file! unless File.exists?(file_path)
        @file = ::File.new(file_path)
      end

      def create_directory!
        run_command("sudo mkdir -p #{dirname}")
      end

      def create_file!
        run_command("sudo touch #{file_path}")
      end

      def dirname
        @dirname = File.dirname(file_path)
      end

      def file_path
        RESOLVER_PATH
      end

      def config
        CONFIG
      end

      def write!
        return if contains_lines?(config)
        run_command("echo '#{config}' | sudo tee -a #{file_path}")
      end
    end
  end
end
