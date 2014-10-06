require "logger"

module Wak
  class Logger < ::Logger
    def red(s); "\e[31m#{s}\e[0m";end
    def green(s); "\e[32m#{s}\e[0m";end

    def problem(title, message)
      warn("#{red(title)}: #{message}")
    end

    def ok(title, message)
      info("#{green(title)}: #{message}")
    end

  end
end
