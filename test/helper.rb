# coding: utf-8
require "minitest"
require "minitest/autorun"
require "minitest/pride"
require 'mocha/mini_test'
require "pry"
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'wak'
class MiniTest::Spec
  before do
    Wak::Setup::Package::Base.any_instance.stubs(:run_command).returns("")
    Wak::Setup::DnsConfigurator.any_instance.stubs(:run_command).returns("")
    Wak::Setup::Package::Nginx.any_instance.stubs(:create_sites_dir!)
    Wak.stubs(:logger).returns(::Wak::Logger.new(nil))
  end
end
