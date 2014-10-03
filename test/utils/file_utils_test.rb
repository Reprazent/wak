require "helper"

class FakeClass
  include Wak::Utils::FileUtils
end

describe Wak::Utils::FileUtils do

  before do
    @thing = FakeClass.new
    @test_file = Tempfile.new("test_file_utils")
    File.open(@test_file.path, "w") do |f|
      f.write("http {\n")
      f.write("}")
    end
    @thing.file = @test_file
  end

  it "has a file attribute" do
    @thing.respond_to? :file
  end

  it "can get the lines of a file" do
    assert_equal "http {", @thing.file_content.first
  end

  it "can detect lines in a file" do
    assert @thing.contains_lines?("}")
  end

end
