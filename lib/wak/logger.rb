require "logger"

module Wak
  class Logger < ::Logger
    def red(s); "\e[31m#{s}\e[0m";end
    def green(s); "\e[32m#{s}\e[0m";end

    def problem(title, message, extras=[])
      puts
      extras = Array(extras)
      warn("#{red(title)}: #{message}")
      extras.each do |extra|
        prefix = " " * (title.length + 1)
        info("#{prefix} #{extra}")
      end
      puts
    end

    def ok(title, message)
      info("#{green(title)}: #{message}")
    end

  end
end
