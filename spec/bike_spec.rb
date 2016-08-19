require 'Bike'

describe Bike do
  it { is_expected.to respond_to :working?}

  describe 'Does the bike release when broken?' do
  it 'does not release a broken bike' do
     expect(subject.broken?).to eq false
    end
  end
end
