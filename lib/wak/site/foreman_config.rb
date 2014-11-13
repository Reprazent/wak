module Wak
  class Site
    class ForemanConfig < Config
      def procfile_path
        @procfile ||= File.join(path, ".Procfile.wak")
      end
    end
  end
end
