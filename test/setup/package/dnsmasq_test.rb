
require "helper"

describe Wak::Setup::Package::Dnsmasq do
  before do
    @dnsmasq = Wak::Setup::Package::Dnsmasq.new
    @dnsmasq.stubs(:launchd_loaded?).returns(false)
  end

  it "has the correct name" do
    assert_equal "dnsmasq", @dnsmasq.name
  end

  it "raises an error when the package is not installed yet" do
    @dnsmasq.stubs(:package_installed?).returns(false)
    assert_raises Wak::MissingPackage do
      @dnsmasq.install!
    end
  end

  it "configures and starts itself on installation" do
    @dnsmasq.stubs(:package_installed?).returns(true)
    @dnsmasq.expects(:configure!)
    @dnsmasq.expects(:start!)
    @dnsmasq.install!
  end

  describe "configuration" do

    it "opens the correct configuration file" do
      Wak::Setup::Package::Configuration::File.expects(:new).with("/usr/local/etc/dnsmasq.conf")
      @dnsmasq.config_file
    end

    describe "writing" do
      before do
        @test_file = Tempfile.new("test_dnsmasq")
        @dummy_config = Wak::Setup::Package::Configuration::File.new(@test_file.path)
        @dnsmasq.stubs(:config_file).returns(@dummy_config)
      end

      it "should write the correct configuration" do
        @dnsmasq.configure!
        dummy_config = "address=/.dev/127.0.0.1"
        assert_equal dummy_config, @test_file.read
      end
    end

  end
end
