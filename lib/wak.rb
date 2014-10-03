require "logger"
require "wak/version"
require "wak/setup/package/base"
require "wak/setup/package/nginx"
require "wak/setup/package/dnsmasq"
require "wak/setup/package/configuration/file"

module Wak
  class MissingConfigFile < StandardError; end
  class CommandException < StandardError; end

  def self.logger
    @@logger ||= Logger.new(STDOUT).tap do |l|
      l.formatter = proc do |severity, datetime, progname, msg|
        "#{msg}\n"
      end
    end
  end

end
