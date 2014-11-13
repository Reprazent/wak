NGINX_RESULT = <<TEMPLATE
upstream hound {
  server unix:/tmp/hound.sock;
}

server {
    listen      80;
    server_name hound.dev;
    client_max_body_size 4G;
    keepalive_timeout 5;

    root /test/path/hound/public;

    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_pass_header X-Accel-Redirect;
        proxy_read_timeout 300s;
        if (!-f $request_filename) {
          proxy_pass http://hound;
          break;
        }
    }
}
TEMPLATE

describe Wak::Site::NginxConfig do

  before do
    fake_site = mock
    fake_site.stubs(:app_name).returns("hound")
    fake_site.stubs(:path).returns("/test/path/hound")
    @config ||= Wak::Site::NginxConfig.new(fake_site)
  end

  it "knows where its nginx site should be" do
    nginx = mock
    nginx.expects(:sites_path).returns("~/.config/wak/sites")
    Wak::Setup::Package.expects(:nginx).returns(nginx)
    assert_equal "~/.config/wak/sites/hound.dev", @config.nginx_site_path.to_s
  end

  it "can render the template" do
    assert_equal NGINX_RESULT, @config.render
  end

end
