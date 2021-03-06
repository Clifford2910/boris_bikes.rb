require 'docking_station.rb'

describe DockingStation do

  let(:bike) { double :bike, working: true }
  let(:broken_bike) { double :bike, working: false }

  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'Docking station empty'
    end

    it 'releases a bike' do
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'releases working bikes' do
      expect(bike.working).to eq true
    end

    it 'cannot release broken bikes' do
      subject.dock(broken_bike)
      expect { subject.release_bike }.to raise_error 'Docking station empty'
    end
  end

  describe '#dock' do
    it 'raises an error when there are too many bikes docked' do
      subject.capacity = 1
      subject.dock(bike)
      expect { subject.dock(bike) }.to raise_error 'Docking station full'
    end

    it 'docks a bike' do
      subject.dock(bike)
      expect(subject.working_bikes).to include(bike)
    end

    it 'docks a broken bike' do
      subject.dock(broken_bike)
      expect(subject.broken_bikes).to include(broken_bike)
    end
  end

  describe '#capacity' do
    it 'has a default capacity' do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end
  end
end
