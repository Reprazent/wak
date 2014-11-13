module Wak
  class Site
    class NginxConfig < Config

      def nginx_site_path
        @nginx_site_path ||= File.join(Wak::Setup::Package.nginx.sites_path, "#{app_name}.dev")
      end

    end
  end
end
