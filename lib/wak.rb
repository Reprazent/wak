require "wak/version"
require "wak/logger"
require "wak/utils/file_utils"
require "wak/utils/runner"
require "wak/setup/dns_configurator"
require "wak/setup/setup_runner"
require "wak/setup/package/base"
require "wak/setup/package/nginx"
require "wak/setup/package/dnsmasq"
require "wak/setup/package/configuration/file"

module Wak
  class MissingConfigFile < StandardError; end
  class CommandException < StandardError; end
  class MissingPackage < StandardError; end



  def self.logger
    @@logger ||= Wak::Logger.new(STDOUT).tap do |l|
      l.formatter = proc do |severity, datetime, progname, msg|
        "#{msg}\n"
      end
    end
  end

end
