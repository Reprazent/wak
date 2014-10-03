require "helper"

describe Wak::Setup::Package::Configuration::File do
  it "raises an error if a config file is missing" do
    ::File.expects(:exists?).with("nonexistant").returns(false)
    assert_raises Wak::MissingConfigFile do
      Wak::Setup::Package::Configuration::File.new("nonexistant")
    end
  end

  describe "config" do
    before do
      @tempfile = Tempfile.new("waktest")
      @config_file = Wak::Setup::Package::Configuration::File.new(@tempfile.path)
    end

    it "can add lines to the content" do
      @config_file.expects(:file_content).returns([""]).twice
      assert_equal ["", "hello world"], @config_file.build_new_config("hello world")
    end

    it "can add lines to the content after a specified line" do
      @config_file.expects(:file_content).returns(["", "   test    ", "empty"]).twice
      assert_equal ["", "   test    ", "hello world", "empty"], @config_file.build_new_config("hello world", "test")
    end

    it "can detect if the config was already added" do
      @config_file.expects(:file_content).returns(["  this is my config"])
      assert @config_file.has_config?("this is my config")
    end

    it "can write the config to a file" do
      @config_file.write_config(["hello", "world"])
      assert_equal "hello\nworld", ::File.read(@tempfile.path)
    end
  end
end
