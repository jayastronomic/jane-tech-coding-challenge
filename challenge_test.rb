require 'rspec/autorun'
require_relative 'challenge.rb'

RSpec.describe Challenge do
  describe '.find_number_of_teams' do
      let(:input) { "Chicago CareBears 3, San Antonio Bisons 3\nNew York Pinheads 6, Sacremento Minors 5\n" + 
        "San Jose Earthquakes 3, Santa Cruz Slugs 3\nCapitola Seahorses 1, Aptos FC 0" }
     
      it 'returns the number of teams in a league' do 
      expect(described_class.find_number_of_teams(input)).to eq(8)
    end
  end

  describe '.games_per_matchday' do
    let(:input) { "Chicago CareBears 3, San Antonio Bisons 3\n" }
    let(:teams) { described_class.find_number_of_teams(input) }

    it 'returns the number of games per match day' do
      expect(described_class.games_per_match_day(teams)).to eq(1)
    end
  end
end
