class CommandException < StandardError; end
module Wak
  class Package

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def package_installed?
      run_command("which #{name}") != "#{name} not found"
    end

    def install!
      run_command("brew install #{name}") unless package_installed?
    end

    def run_command(command)
      `#{command}`
    rescue StandardError => e
      raise CommandException.new(e) unless $?.success?
    end

  end
end
