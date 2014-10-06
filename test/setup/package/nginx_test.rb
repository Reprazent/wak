require "helper"

describe Wak::Setup::Package::Nginx do
  before do
    @nginx = Wak::Setup::Package::Nginx.new
    @nginx.stubs(:package_installed?).returns(false)
    @nginx.stubs(:launchd_loaded?).returns(false)
  end

  it "has the correct name" do
    assert_equal "nginx", @nginx.name
  end

  it "configures and starts itself on installation" do
    @nginx.expects(:configure!)
    @nginx.expects(:start!)
    @nginx.install!
  end

  describe "configuration" do

    it "opens the correct configuration file" do
      Wak::Setup::Package::Configuration::File.expects(:new).with("/usr/local/etc/nginx/nginx.conf")
      @nginx.config_file
    end

    describe "writing" do
      before do
        @test_file = Tempfile.new("test_nginx")
        File.open(@test_file.path, "w") do |f|
          f.write("http {\n")
          f.write("}")
        end
        Dir.stubs(:home).returns("/Users/bvl")
        @dummy_config = Wak::Setup::Package::Configuration::File.new(@test_file.path)
        @nginx.stubs(:config_file).returns(@dummy_config)
      end

      it "should write the correct configuration" do
        @nginx.configure!
        dummy_config = "http {\ninclude /Users/bvl/.config/wak/sites/*.conf;\n}"
        assert_equal dummy_config, @test_file.read
      end
    end

  end
end
