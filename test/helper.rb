# coding: utf-8
require "minitest"
require "minitest/autorun"
require 'mocha/mini_test'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'wak'
class MiniTest::Spec
  before do
    Wak::Package::Base.any_instance.stubs(:run_command).returns("")
    Wak.stubs(:logger).returns(Logger.new(nil))
  end
end
