require "helper"

class FakeRunner
  include Wak::Utils::Runner
end

describe Wak::Utils::Runner do
  before do
    @thing = FakeRunner.new
  end

  it "raises an error when a shell command fails" do
    assert_raises Wak::CommandException do
      @thing.run_command("broken command")
    end
  end
end
