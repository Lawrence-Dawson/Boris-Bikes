require_relative 'bike'

class DockingStation
  attr_accessor :capacity


  DEFAULT_CAPACITY = 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    fail 'No bikes available' if bikes.empty?
    bikes.pop
  end

  def dock(bike)
    fail 'Docking Station full' if full?
    bikes << bike
  end

  def report_broken(bike)
    bike.working = false
  end

  private

  attr_reader :bikes

  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end
end
