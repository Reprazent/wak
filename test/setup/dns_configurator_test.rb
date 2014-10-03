require "helper"

describe Wak::Setup::DnsConfigurator do
  it "writes to the correct file" do
    ::File.expects(:new).with("/etc/resolver/dev")
    Wak::Setup::DnsConfigurator.new
  end

  describe "file access" do
    before do
      @tempfile = Tempfile.open("dns_config_test") do |f|
        f << "# hello world"
      end
      Wak::Setup::DnsConfigurator.any_instance.stubs(:file_path).returns(@tempfile.path)
      @configurator = Wak::Setup::DnsConfigurator.new
    end

    describe "writing the configuration" do
      before do
      end

      it "appends the config to a file" do
        @configurator.expects(:run_command).with("echo 'nameserver 127.0.0.1' | sudo tee -a #{@tempfile.path}")
        @configurator.write!
      end

    end

  end

end
