require "helper"

describe Wak::Package::Base do
  before do
    @info = Wak::Package::Base.new("nginx")
  end

  it "knows when a package is installed" do
    @info.expects(:run_command).with("which nginx").returns("/usr/local/bin/nginx")
    assert @info.package_installed?
  end

  it "can install itself" do
    @info.expects(:package_installed?).returns(false)
    @info.expects(:run_install_command)
    @info.expects(:run_copy_launchd)
    @info.expects(:run_load_launchd)
    @info.install!
  end

  it "doesn't try to install itself when it was already installed" do
    @info.expects(:package_installed?).returns(true)
    @info.expects(:run_install_command).never
    @info.install!
  end

  describe "shell commands" do
    before do
      Wak::Package::Base.any_instance.unstub(:run_command)
    end

    it "raises an error when a shell command fails" do
      assert_raises Wak::CommandException do
        @info.run_command("broken command")
      end
    end

    it "installs using homebrew" do
      @info.expects(:run_command).with("brew install nginx")
      @info.run_install_command
    end

    it "can link launchdeamons" do
      link_cmd = "sudo cp -fv /usr/local/opt/nginx/*.plist /Library/LaunchDaemons"
      @info.expects(:run_command).with(link_cmd)
      @info.run_copy_launchd
    end

    it "can load launchdeamons" do
      load_cmd = "sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist"
      @info.expects(:run_command).with(load_cmd)
      @info.run_load_launchd
    end

  end

end
