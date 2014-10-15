require "logger"

module Wak
  class Logger < ::Logger
    def red(s); "\e[31m#{s}\e[0m";end
    def green(s); "\e[32m#{s}\e[0m";end

    def problem(title, message, extras=[])
      info
      extras = Array(extras)
      warn("#{red(title)}: #{message}")
      extras.each do |extra|
        prefix = " " * (title.length + 1)
        info("#{prefix} #{extra}")
      end
    end

    def command(command)
      info "Running `#{command}`"
    end

    def output(output)
      prefix = " " * 3
      info("#{prefix} #{output}")
    end

    def ok(title, message)
      info
      info("#{green(title)}: #{message}")
    end

    def install_message(message)
      info
      info message.center 50
      info "-" * 50
    end


  end
end
