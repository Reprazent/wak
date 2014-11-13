require "helper"

describe Wak::Site do

  before do
    @site = Wak::Site.new("/User/bvl/Documents/projects/hound")
  end

  it "fails when an invalid path is given" do
    assert_raises Wak::InvalidSiteDirectory do
      @site.app_name
    end
  end

  it "can get an application name from a path" do
    fake_path = "/test/path"
    fake_path.expects(:directory?).returns(true)
    fake_path.expects(:basename).returns("path")
    @site.expects(:path).returns(fake_path).twice
    assert_equal "path", @site.app_name
  end

end
