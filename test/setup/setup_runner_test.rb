require "helper"

describe Wak::Setup::SetupRunner do
  before do

  end

  it "can builds both ngnix and dnsmasq" do
    Wak::Setup::Package::Dnsmasq.expects(:new)
    Wak::Setup::Package::Nginx.expects(:new)
    Wak::Setup::SetupRunner.new
  end

  it "installs all teh packages when they aren't installed yet" do
    runner = Wak::Setup::SetupRunner.new
    package = Wak::Setup::Package::Nginx.new
    package.expects(:package_installed?).returns(false)
    package.expects(:install!)
    runner.expects(:packages).returns([package])
    runner.install_packages
  end

  it "configures the dns and installs the packages on run" do
    runner = Wak::Setup::SetupRunner.new
    runner.expects(:install_packages)
    runner.expects(:configure_dns)
    runner.run
  end

end
