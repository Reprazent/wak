require "logger"
require "wak/version"
require "wak/package/base"
require "wak/package/nginx"
require "wak/package/configuration/file"

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
