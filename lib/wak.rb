require "logger"
require "wak/version"
require "wak/package/base"
require "wak/package/nginx"


module Wak

  def self.logger
    @@logger ||= Logger.new(STDOUT).tap do |l|
      l.formatter = proc do |severity, datetime, progname, msg|
        "#{msg}\n"
      end
    end
  end

end
