describe Wak::Site::NginxConfig do

  before do
    fake_site = mock
    fake_site.stubs(:app_name).returns("hound")
    @config ||= Wak::Site::NginxConfig.new(fake_site)
  end

  it "knows where its nginx site should be" do
    nginx = mock
    nginx.expects(:sites_path).returns("~/.config/wak/sites")
    Wak::Setup::Package.expects(:nginx).returns(nginx)
    assert_equal "~/.config/wak/sites/hound.dev", @config.nginx_site_path.to_s
  end

end
