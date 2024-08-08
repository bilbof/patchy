require 'diffy'
require './patchy/patch'

RSpec.describe Patchy do
  it "exists" do
    expect(Patchy).not_to be_nil
  end

  Dir["./spec/test_cases/*"].each do |dir|
    it "patches #{dir.split("/").last}" do
      file1, file2 = File.read("#{dir}/1.txt"), File.read("#{dir}/2.txt")
      expect(file1).not_to eq(file2)
      diffy = Diffy::Diff.new(file1, file2, context: 0, include_diff_info: true)
      patchy = Patchy::Patch.new(file1, diffy.diff)
      expect(patchy.patched).to eq(file2)
    end
  end
end
