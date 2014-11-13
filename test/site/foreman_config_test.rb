require "helper"

describe Wak::Site::ForemanConfig do
  before do
    fake_site = mock
    fake_site.stubs(:path).returns("/test/path/hound")
    @config ||= Wak::Site::ForemanConfig.new(fake_site)
  end

  it "knows where it's procfile is" do
    assert_equal "/test/path/hound/.Procfile.wak", @config.procfile_path.to_s
  end

end
