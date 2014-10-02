require "helper"

describe Wak::Package do
  before do
    @info = Wak::Package.new("nginx")
  end

  it "knows when a package is installed" do
    @info.expects(:run_command).with("which nginx").returns("/usr/local/bin/nginx")
    assert @info.package_installed?
  end

  it "can install itself" do
    @info.expects(:package_installed?).returns(false)
    @info.expects(:run_command).with("brew install nginx")
    @info.install!
  end

  it "doesn't try to install itself when it was already installed" do
    @info.expects(:package_installed?).returns(true)
    @info.expects(:run_command).with("brew install nginx").never
    @info.install!
  end

  it "raises an error when a shell command fails" do
    assert_raises CommandException do
      @info.run_command("broken command")
    end
  end
end
