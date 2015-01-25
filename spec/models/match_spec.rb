require 'spec_helper'

RSpec.describe Match, :type => :model do

  let(:home_team) { Team.create(name: "Gospodarz") }
  let(:away_team) { Team.create(name: "Gosc") }
  let(:date) { Time.new(2015, 02, 13) }

  subject { described_class.new(home_team: home_team, away_team: away_team, start_date: date) }

  describe "walidacje" do
    context "kiedy wprowadzone atrubuty są poprawne" do
      it "zwraca prawdę" do
        expect(subject).to be_valid
      end
    end

    context "kiedy spotkanie istnieje już w systemie" do
      let(:duplicated_match) { described_class.new(home_team: home_team, away_team: away_team, start_date: date) }

      before { described_class.create(home_team: home_team, away_team: away_team, start_date: date) }

      it "zwraca fałsz" do
        expect(duplicated_match).to_not be_valid
      end
    end
  end
end
