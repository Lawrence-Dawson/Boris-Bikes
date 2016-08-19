require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  describe '#release_bike' do
    it 'releases working bikes' do
    bike = double(:bike, :working => true)
    subject.dock(bike)
    #allow(bike).to receive(:working).and_return(true)
    expect(subject.release_bike).to eq bike
  end
end

  describe "no bikes available" do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end

  describe '#dock' do
  it 'raises an error when the dock is full' do
    subject.capacity.times { subject.dock(double(:bike)) }
    expect { subject.dock(double(:bike)) }.to raise_error 'Docking Station full'
    end
  end

  describe "dock capacity" do
    it "sets dock capacity" do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end

  describe 'initialization' do
    let(:bike) { double(:bike) }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Docking Station full'
    end
  end

  it 'reporting a bike broken to the docking station' do
    bike = double(:bike, :report_broken => false)
    expect(subject.dock(bike)).to include bike
  end

  it 'does not release a broken bike' do
    bike = double(:bike, :working => false)
    subject.dock(bike)
    expect{ subject.release_bike }.to raise_error 'Error, cannot release a broken bike.'
  end

  it 'working bikes can be docked at docking station' do
    bike = double(:bike)
    subject.dock(bike)
    expect(subject.instance_variable_get(:@bikes)).to include bike
  end

  it 'broken bikes can be docked at docking station' do
    bike = double(:bike, :working => false)
    subject.dock(bike)
    expect(subject.instance_variable_get(:@bikes)).to include bike
  end
end
