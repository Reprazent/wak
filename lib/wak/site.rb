module Wak
  class Site

    attr_accessor :root_dir

    def initialize(root_dir)
      @root_dir = root_dir
    end

    def path
      @pathname ||= Pathname.new(root_dir)
    end

    def app_name
      @app_name ||= begin
                      fail InvalidSiteDirectory.new unless path.directory?
                      path.basename.to_s
                    end
    end

    def foreman_config
      @foreman_config ||= Wak::Site::ForemanConfig.new(self)
    end

    def nginx_config
      @foreman_config ||= Wak::Site::NginxConfig.new(self)
    end

  end
end
