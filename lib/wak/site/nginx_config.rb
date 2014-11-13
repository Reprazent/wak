module Wak
  class Site
    class NginxConfig < Config
      # TODO: Factor this out into a setting
      self.template_file = File.join(File.dirname(__FILE__), "../../../templates/nginx_config.moustache")

      def nginx_site_path
        @nginx_site_path ||= File.join(Wak::Setup::Package.nginx.sites_path, "#{app_name}.dev")
      end

    end
  end
end
