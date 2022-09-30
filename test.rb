require 'rspec/autorun'
require_relative 'challenge.rb'

RSpec.describe Challenge do
  describe '.get_teams' do 
    it 'it returns the number of teams in a league' do
      expect(described_class.get_teams).to eq(6)
    end
  end

  describe '.to_json' do
    subject { described_class.format }

    it 'returns an array' do
      expect(subject.class).to eq(Array)
    end
  end

  describe '.log_matchday_results' do
    it 'it returns the results of each matchday as a file' do
      expect(File.file?("julians_output.txt")).to be_truthy
    end
  end
end
